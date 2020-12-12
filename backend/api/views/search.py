from rest_framework import status
from rest_framework.response import Response
from rest_framework.request import Request
from rest_framework.decorators import api_view
from api.serializers.search import SearchSerializer
from api.serializers.event import EventSerializer
from api.serializers.project import ProjectGETSerializer
from api.serializers.profile import ProfileSerializer
from api.models.event import Event
from api.models.project import Project
from api.models.profile import Profile
from django.db.models import Q


@api_view(['POST'])
def search(request: Request):
    """
        Execute a search with a string
    """
    if request.method == 'POST':
        serializer = SearchSerializer(data=request.data)

        serializer.is_valid(raise_exception=True)
        keyword = serializer.validated_data['keyword']
        res = {'events': [], 'projects': [], 'profiles': []}

        query_events = Event.objects.filter(
            Q(title__icontains=keyword) |
            Q(description__icontains=keyword)
        )
        query_projects = Project.objects.filter(
            Q(is_public=True) &
            Q(name__icontains=keyword) |
            Q(description__icontains=keyword) |
            Q(project_type__icontains=keyword) |
            Q(event__title__icontains=keyword) |
            Q(event__description__icontains=keyword)
        )
        query_profiles = Profile.objects.filter(
            Q(name__icontains=keyword) |
            Q(middle_name__icontains=keyword) |
            Q(last_name__icontains=keyword) |
            Q(expertise__icontains=keyword) |
            Q(interests__icontains=keyword) |
            Q(share_bio=True) & Q(bio__icontains=keyword) |
            Q(share_affiliations=True) & Q(affiliations__icontains=keyword)
        )

        res['events'] = EventSerializer(query_events, many=True).data
        res['projects'] = ProjectGETSerializer(
            query_projects, many=True).data
        res['profiles'] = ProfileSerializer(query_profiles, many=True).data

        return Response(data=res, status=status.HTTP_200_OK)
