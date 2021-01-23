from django.db.models import Q
from api.models.profile import Profile
from api.models.project import Project
from api.models.event import Event
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework import generics
from api.serializers.search import SearchRequestSerializer
from api.serializers.event import EventSerializer
from api.serializers.project import ProjectPrivateSerializer
from api.serializers.profile import ProfileBasicSerializer
from api.serializers.profile import ProfilePrivateSerializer
from datamuse import datamuse
from api.models.following import Following
from django.contrib.auth.models import AnonymousUser
import re
from api.utils import get_user_rating
import math


class SearchGenericAPIView(generics.GenericAPIView):
    """
        Execute a search with a string
    """
    serializer_class = SearchRequestSerializer

    def post(self, request: Request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)

        req_data = serializer.validated_data

        keyword_req = req_data['keyword']
        search_type = req_data['search_type']

        api = datamuse.Datamuse()
        keyword_list = api.words(rel_jja=keyword_req, max=5)
        keywords = [keyword_req]
        for keyword_dict in keyword_list:
            keywords.append(keyword_dict['word'])

        res = {}

        query_events = []
        query_profiles = []
        query_followed_profiles = []
        query_private_profiles = []
        query_projects = []
        query_private_projects = []

        isGuest = isinstance(request.user, AnonymousUser)
        search_projects = search_type in ["all", "project"]
        search_profiles = search_type in ["all", "profile"]
        search_events = search_type in ["all", "event"]

        any_project_filter = len(set(["project_due_date_after",
                                      "project_due_date_before",
                                      "project_event", "project_state"])
                                 .intersection(set(req_data.keys()))) > 0
        any_profile_filter = len(set(["profile_affiliations",
                                      "profile_expertise"])
                                 .intersection(set(req_data.keys()))) > 0

        query_following = []
        if not isGuest:
            query_following = list(map(lambda following: following.to_user,
                                       Following.objects.
                                       filter(from_user=request.user)))

        for keyword in keywords:
            if search_events:
                q = Q(title__icontains=keyword) | Q(
                    description__icontains=keyword)

                if "event_date_after" in req_data:
                    q &= Q(date__gte=req_data["event_date_after"])
                if "event_date_before" in req_data:
                    q &= Q(date__lte=req_data["event_date_before"])
                if "event_deadline_after" in req_data:
                    q &= Q(deadline__gte=req_data["event_deadline_after"])
                if "event_deadline_before" in req_data:
                    q &= Q(deadline__lte=req_data["event_deadline_before"])
                if "event_type" in req_data:
                    q &= Q(event_type=req_data["event_type"])

                query_events += Event.objects.filter(q)

            if search_projects:
                q = Q()

                if isGuest:
                    q = Q(is_public=True)
                else:
                    q = (Q(is_public=True) | Q(
                        members__id=request.user.id))

                if "project_due_date_after" in req_data:
                    q &= Q(due_date__gte=req_data["project_due_date_after"])
                if "project_due_date_before" in req_data:
                    q &= Q(due_date__lte=req_data["project_due_date_before"])
                if "project_event" in req_data:
                    q &= Q(event__id=req_data["project_event"])
                if "project_state" in req_data:
                    q &= Q(state=req_data["project_state"])

                q &= (Q(name__icontains=keyword) |
                      Q(description__icontains=keyword) |
                      Q(project_type__icontains=keyword) |
                      Q(event__title__icontains=keyword) |
                      Q(event__description__icontains=keyword))

                query_projects += Project.objects.filter(q)

                if not any_project_filter:
                    q = Q()
                    if isGuest:
                        q = Q(is_public=False)
                    else:
                        q = (Q(is_public=False) & ~Q(
                            members__id=request.user.id))
                    q &= (Q(name__icontains=keyword) |
                          Q(description__icontains=keyword))

                    query_private_projects += Project.objects.filter(q)

            if search_profiles:
                q = Q(is_public=True)
                q &= (Q(name__icontains=keyword) |
                      Q(middle_name__icontains=keyword) |
                      Q(last_name__icontains=keyword) |
                      Q(expertise__icontains=keyword) |
                      Q(interests__icontains=keyword) |
                      (Q(share_bio=True) & Q(bio__icontains=keyword)) |
                      (Q(share_affiliations=True) &
                       Q(affiliations__icontains=keyword)))

                if "profile_affiliations" in req_data:
                    q &= Q(
                        affiliations__icontains=req_data[
                            "profile_affiliations"])
                if "profile_expertise" in req_data:
                    q &= Q(expertise__icontains=req_data["profile_expertise"])

                query_profiles += Profile.objects.filter(q)

                if not isGuest:
                    q = (Q(is_public=False) & Q(owner__in=query_following))

                    q &= (Q(name__icontains=keyword) |
                          Q(middle_name__icontains=keyword) |
                          Q(last_name__icontains=keyword) |
                          Q(expertise__icontains=keyword) |
                          Q(interests__icontains=keyword) |
                          (Q(share_bio=True) & Q(bio__icontains=keyword)) |
                          (Q(share_affiliations=True) &
                           Q(affiliations__icontains=keyword)))

                    if "profile_affiliations" in req_data:
                        q &= Q(
                            affiliations__icontains=req_data[
                                "profile_affiliations"])
                    if "profile_expertise" in req_data:
                        q &= Q(
                            expertise__icontains=req_data["profile_expertise"])

                    query_followed_profiles += Profile.objects.filter(q)

                if not any_profile_filter:
                    q = Q()
                    if isGuest:
                        q = Q(is_public=False)
                    else:
                        q = (Q(is_public=False) & ~Q(
                            owner__in=query_following))
                    q &= (Q(name__icontains=keyword) |
                          Q(middle_name__icontains=keyword) |
                          Q(last_name__icontains=keyword))

                    query_private_profiles += Profile.objects.filter(q)

        if search_events:
            query_events = list(set(query_events))

            event_serializer = EventSerializer(query_events, many=True,
                                               context={'request': request})

            res['events'] = event_serializer.data

        if search_projects:
            query_projects = list(set(query_projects))
            query_private_projects = list(set(query_private_projects))

            profile = Profile.objects.filter(
                owner_id=self.request.user.id).first()
            exps = []
            projects_all = query_projects + query_private_projects

            if profile:
                if profile.expertise:
                    exps = re.split('; |, |\n', profile.expertise)
                    exps = [r.strip() for r in exps]

                project_score = {}
                followed_users = Following.objects.filter(
                    from_user=self.request.user)

                for project in projects_all:
                    rating = get_user_rating(project.owner_id)
                    scaled_rating = rating/10.0 if rating else 0.5
                    project_score[project.id] = [1 + scaled_rating, 1, 1]

                    members = project.members.all()
                    members = [member.id for member in members]
                    if self.request.user.id in members:
                        project_score[project.id][2] = 5
                    else:
                        for followed in followed_users:
                            if followed.to_user.id in members:
                                project_score[project.id][2] = 1.5
                                break
                    for x in exps:
                        if x in project.requirements:
                            project_score[project.id][1] += 1

                for project_id, scores in project_score.items():
                    project_score[project_id] = math.prod(scores)

                top_ids = [i for i in sorted(project_score,
                                             key=project_score.get,
                                             reverse=True)]

                query_projects_all = [project for pid in top_ids
                                      for project in projects_all
                                      if project.id == pid]

                private_project_serializer = ProjectPrivateSerializer(
                    query_projects_all, many=True,
                    context={'request': request})

                res['projects'] = private_project_serializer.data

            else:
                private_project_serializer = ProjectPrivateSerializer(
                    projects_all, many=True,
                    context={'request': request})

                res['projects'] = private_project_serializer.data

        if search_profiles:
            query_profiles = list(set(query_profiles))
            query_followed_profiles = list(set(query_followed_profiles))
            query_private_profiles = list(set(query_private_profiles))

            profile_serializer = ProfileBasicSerializer(
                query_profiles, many=True,
                context={'request': request})
            followed_profile_serializer = ProfileBasicSerializer(
                query_followed_profiles, many=True,
                context={'request': request})
            private_profile_serializer = ProfilePrivateSerializer(
                query_private_profiles, many=True,
                context={'request': request})

            res['profiles'] = profile_serializer.data + \
                followed_profile_serializer.data + \
                private_profile_serializer.data

        return Response(data=res)
