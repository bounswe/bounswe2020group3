from rest_framework import viewsets
from rest_framework import permissions
from api.models.publication import Publication
from api.models.profile import Profile
from api.serializers.publication import PublicationSerializer
from scholarly import scholarly
from django.shortcuts import get_object_or_404
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from django_filters.rest_framework import DjangoFilterBackend

author_param = openapi.Parameter(
    'author_id', openapi.IN_QUERY, description="Google Scholar id of author",
    type=openapi.TYPE_STRING)
profile_param = openapi.Parameter(
    'profile_id', openapi.IN_QUERY, description="Profile id to add",
    type=openapi.TYPE_INTEGER)


class PublicationViewSet(viewsets.ModelViewSet):

    queryset = Publication.objects.all()
    serializer_class = PublicationSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['profile__id']

    @swagger_auto_schema(
        method='post', manual_parameters=[author_param, profile_param]
    )
    @action(detail=False, methods=['post'], name='add_publications',
            serializer_class=None)
    def add_publications(self, request):
        profile_id = request.GET.get('profile_id', None)
        profile = get_object_or_404(Profile, pk=profile_id)
        if self.request.user != profile.owner:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)
        Publication.objects.filter(
            profile=profile
        ).delete()
        author_id = request.GET.get('author_id', None)
        author_basic = scholarly.search_author_id(author_id)
        author = scholarly.fill(author_basic)
        data = {}
        for publication in author['publications']:
            publication = scholarly.fill(publication)
            publication_info = publication['bib']
            if 'title' in publication_info:
                data['title'] = publication_info['title']
            if 'pub_year' in publication_info:
                data['publication_year'] = publication_info['pub_year']
            if 'abstract' in publication_info:
                data['abstract'] = publication_info['abstract']
            if 'author' in publication_info:
                data['authors'] = publication_info['author']
            if 'journal' in publication_info:
                data['journal'] = publication_info['journal']
            elif 'publisher' in publication_info:
                data['journal'] = publication_info['publisher']
            if 'num_citations' in publication_info:
                data['citation_number'] = publication_info['num_citations']
            data['profile'] = profile.id
            serializer = PublicationSerializer(data=data)
            serializer.is_valid(raise_exception=True)
            Publication.objects.create(
                **serializer.validated_data)
        return Response(status=status.HTTP_201_CREATED)
