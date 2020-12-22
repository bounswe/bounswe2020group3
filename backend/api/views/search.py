from django.db.models import Q
from api.models.profile import Profile
from api.models.project import Project
from api.models.event import Event
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework import generics
from api.serializers.search import SearchSerializer
from api.serializers.event import EventSerializer
from api.serializers.project import ProjectGETPublicSerializer
from api.serializers.project import ProjectPrivateSerializer
from api.serializers.profile import ProfileBasicSerializer
from api.serializers.profile import ProfilePrivateSerializer
from datamuse import datamuse
from api.models.following import Following
from django.contrib.auth.models import AnonymousUser


class SearchGenericAPIView(generics.GenericAPIView):
    """
        Execute a search with a string
    """
    serializer_class = SearchSerializer

    def post(self, request: Request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        keyword_req = serializer.validated_data['keyword']
        api = datamuse.Datamuse()
        keyword_list = api.words(rel_jja=keyword_req, max=5)
        keywords = [keyword_req]
        for keyword_dict in keyword_list:
            keywords.append(keyword_dict['word'])

        res = {'events': [], 'projects': [], 'profiles': []}

        query_events = []
        query_profiles = []
        query_followed_profiles = []
        query_private_profiles = []
        query_projects = []
        query_private_projects = []

        isGuest = isinstance(request.user, AnonymousUser)

        query_following = []
        if not isGuest:
            query_following = list(map(lambda following: following.to_user,
                                       Following.objects.
                                       filter(from_user=request.user)))

        for keyword in keywords:
            query_events += Event.objects.filter(
                Q(title__icontains=keyword) |
                Q(description__icontains=keyword)
            )

            if isGuest:
                query_projects += Project.objects.filter(
                    Q(is_public=True) &
                    (Q(name__icontains=keyword) |
                     Q(description__icontains=keyword) |
                        Q(project_type__icontains=keyword) |
                        Q(event__title__icontains=keyword) |
                        Q(event__description__icontains=keyword))
                )
                query_private_projects += Project.objects.filter(
                    Q(is_public=False) &
                    (Q(name__icontains=keyword) |
                     Q(description__icontains=keyword))
                )
                query_profiles += Profile.objects.filter(
                    Q(is_public=True) &
                    (Q(name__icontains=keyword) |
                     Q(middle_name__icontains=keyword) |
                     Q(last_name__icontains=keyword) |
                     Q(expertise__icontains=keyword) |
                     Q(interests__icontains=keyword) |
                     (Q(share_bio=True) & Q(bio__icontains=keyword)) |
                     (Q(share_affiliations=True) &
                      Q(affiliations__icontains=keyword)))
                )
                query_private_profiles += Profile.objects.filter(
                    Q(is_public=False) &
                    (Q(name__icontains=keyword) |
                     Q(middle_name__icontains=keyword) |
                     Q(last_name__icontains=keyword))
                )
            else:
                query_projects += Project.objects.filter(
                    (Q(is_public=True) | Q(members__id=request.user.id)) &
                    (Q(name__icontains=keyword) |
                     Q(description__icontains=keyword) |
                     Q(project_type__icontains=keyword) |
                     Q(event__title__icontains=keyword) |
                     Q(event__description__icontains=keyword))
                )
                query_private_projects += Project.objects.filter(
                    (Q(is_public=False) & ~Q(members__id=request.user.id)) &
                    (Q(name__icontains=keyword) |
                     Q(description__icontains=keyword))
                )

                query_profiles += Profile.objects.filter(
                    Q(is_public=True) &
                    (Q(name__icontains=keyword) |
                     Q(middle_name__icontains=keyword) |
                     Q(last_name__icontains=keyword) |
                     Q(expertise__icontains=keyword) |
                     Q(interests__icontains=keyword) |
                     (Q(share_bio=True) & Q(bio__icontains=keyword)) |
                     (Q(share_affiliations=True) &
                      Q(affiliations__icontains=keyword)))
                )
                query_followed_profiles += Profile.objects.filter(
                    (Q(is_public=False) & Q(owner__in=query_following)) &
                    (Q(name__icontains=keyword) |
                     Q(middle_name__icontains=keyword) |
                     Q(last_name__icontains=keyword) |
                     Q(expertise__icontains=keyword) |
                     Q(interests__icontains=keyword) |
                     (Q(share_bio=True) & Q(bio__icontains=keyword)) |
                     (Q(share_affiliations=True) &
                      Q(affiliations__icontains=keyword)))
                )
                query_private_profiles += Profile.objects.filter(
                    (Q(is_public=False) & ~Q(owner__in=query_following)) &
                    (Q(name__icontains=keyword) |
                     Q(middle_name__icontains=keyword) |
                     Q(last_name__icontains=keyword))
                )

        query_events = list(set(query_events))
        query_profiles = list(set(query_profiles))
        query_followed_profiles = list(set(query_followed_profiles))
        query_private_profiles = list(set(query_private_profiles))
        query_projects = list(set(query_projects))
        query_private_projects = list(set(query_private_projects))

        event_serializer = EventSerializer(query_events, many=True)

        project_serializer = ProjectGETPublicSerializer(
            query_projects, many=True)
        private_project_serializer = ProjectPrivateSerializer(
            query_private_projects, many=True)

        profile_serializer = ProfileBasicSerializer(query_profiles, many=True)
        followed_profile_serializer = ProfileBasicSerializer(
            query_followed_profiles, many=True)
        private_profile_serializer = ProfilePrivateSerializer(
            query_private_profiles, many=True)

        res['events'] = event_serializer.data
        res['projects'] = project_serializer.data + \
            private_project_serializer.data
        res['profiles'] = profile_serializer.data + \
            followed_profile_serializer.data + private_profile_serializer.data

        return Response(data=res)
