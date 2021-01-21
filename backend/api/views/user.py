from rest_framework import viewsets
from django.contrib.auth.models import User
from api.models.profile import Profile
from api.serializers.user import UserFullSerializer
from api.serializers.user import UserBasicSerializer
from api.serializers.user import UserPrivateSerializer
from rest_framework.response import Response
from api.utils import get_is_following, get_user_rating
from rest_framework.decorators import action
from django.shortcuts import get_object_or_404
from api.models.project import Project
from api.models.following import Following
from api.models.collaboration_invite import CollaborationInvite
import math
import re
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from django.db.models import Case, When

project_param = openapi.Parameter(
    'project_id', openapi.IN_QUERY,
    description="Project id to get recommendations",
    type=openapi.TYPE_INTEGER)


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    """
    This viewset automatically provides `list` and `detail` actions.
    """
    queryset = User.objects.all()

    def retrieve(self, request, *args, **kwargs):
        self.accessed_user = self.get_object()
        serializer = self.get_serializer(self.accessed_user)
        return Response(serializer.data)

    def get_serializer_class(self):
        this_user = self.request.user
        is_get = self.action == 'retrieve'
        is_list = self.action == 'list'
        if this_user.is_staff:
            return UserFullSerializer
        elif is_get:
            is_public = Profile.objects.get(owner=self.accessed_user).is_public
            is_following = get_is_following(this_user, self.accessed_user)
            if self.accessed_user == this_user:
                return UserFullSerializer
            elif is_public or is_following:
                return UserBasicSerializer
            else:
                return UserPrivateSerializer
        elif is_list:
            return UserPrivateSerializer
        else:
            return UserFullSerializer

    @swagger_auto_schema(
        method='get', manual_parameters=[project_param]
    )
    @action(detail=False, methods=['GET'],
            name='get_collaborator_recommendation',
            serializer_class=None)
    def get_collaborator_recommendation(self, request):
        project_id = request.GET.get('project_id', None)
        project = get_object_or_404(Project, pk=project_id)
        project_owner = project.owner_id
        reqs = []
        if project.requirements:
            reqs = re.split('; |, |\n', project.requirements)
            reqs = [r.strip() for r in reqs]

        """
            value of the dictionary items will be a list of length 3:
            [rating_score, expertise_score, following_score]

            The end score calculation will be the following:
            rating_score*expertise_score*following_score

            Base value for rating_score is 1, rating/10 is added to this value.
            If someone has no rating it is treated as a rating of 5.

            Default score for expertise is 1 and is incremented by 1
            with each match with requirements.

            Following_score is 1.2 for the users that the owner follows,
            1 otherwise.
        """

        user_score = {}

        profiles = Profile.objects.all()
        for profile in profiles:
            rating = get_user_rating(profile.owner_id)
            scaled_rating = rating/10.0 if rating else 0.5
            user_score[profile.owner_id] = [1 + scaled_rating, 1, 1]

        for keyword in reqs:
            profiles = Profile.objects.filter(
                expertise__icontains=keyword)
            for profile in profiles:
                user_score[profile.owner_id][1] += 1

        followed_users = Following.objects.filter(from_user=project_owner)
        for followed in followed_users:
            user_score[followed.to_user.id][2] = 1.2

        for user_id, scores in user_score.items():
            user_score[user_id] = math.prod(scores)

        # pop the project members out of the list
        for member in project.members.all():
            user_score.pop(member.id, None)

        invited_users = CollaborationInvite.objects.filter(
            from_user=project_owner,
            to_project=project)
        # pop the invited users out of the list
        for invite in invited_users:
            user_score.pop(invite.to_user.id, None)

        top_ids = [i for i in sorted(user_score,
                                     key=user_score.get,
                                     reverse=True)]

        preserved = Case(*[When(id=pk, then=pos)
                           for pos, pk in enumerate(top_ids)])
        users = User.objects.filter(id__in=top_ids).order_by(preserved)
        serializer_context = {'request': request}
        serializer = UserBasicSerializer(
            users, many=True, context=serializer_context)
        return Response(serializer.data)
