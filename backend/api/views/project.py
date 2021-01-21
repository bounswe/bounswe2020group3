from rest_framework import viewsets
from rest_framework import permissions
from api.permission import IsMemberOrReadOnly
from api.serializers.project import ProjectPublicSerializer
from api.serializers.project import ProjectGETPublicSerializer
from api.serializers.project import ProjectPrivateSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from notifications.signals import notify
from api.models.project import Project
from rest_framework.decorators import action
from api.models.profile import Profile
from api.models.following import Following
from api.models.collaboration_request import CollaborationRequest
import math
import re
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from django.db.models import Case, When
from api.utils import get_user_rating

user_param = openapi.Parameter(
    'user_id', openapi.IN_QUERY,
    description="User id to get recommendations",
    type=openapi.TYPE_INTEGER)


class ProjectViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Project.objects.all()
    serializer_class = ProjectPublicSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsMemberOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['owner__id', 'members__id']

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user, members=[self.request.user])

    def retrieve(self, request, *args, **kwargs):
        self.accessed_project = self.get_object()
        serializer = self.get_serializer(self.accessed_project)
        return Response(serializer.data)

    def get_serializer_class(self):
        this_user = self.request.user
        is_get = self.action == 'retrieve'
        is_list = self.action == 'list'
        if this_user.is_staff:
            return ProjectGETPublicSerializer
        elif is_get and self.accessed_project.owner == this_user:
            return ProjectGETPublicSerializer
        elif is_get and this_user in self.accessed_project.members.all():
            return ProjectGETPublicSerializer
        elif is_get and self.accessed_project.is_public:
            return ProjectGETPublicSerializer
        elif is_get and not self.accessed_project.is_public:
            return ProjectPrivateSerializer
        elif is_list:
            return ProjectPrivateSerializer
        else:
            return ProjectPublicSerializer

    def dispatch(self, request, *args, **kwargs):
        response = super().dispatch(request, *args, **kwargs)
        if self.action == 'create':
            project = Project.objects.get(id=response.data['id'])
            notify.send(sender=self.request.user,
                        verb="created a new Project {}".
                        format(response.data['name']),
                        recipient=self.request.user,
                        target=project,
                        description='Project')
            # send_mail(self.request.user)

        if self.action == 'update':
            pass
        if self.action == 'destroy':
            pass
        return response

    @swagger_auto_schema(
        method='get', manual_parameters=[user_param]
    )
    @action(detail=False, methods=['GET'],
            name='get_project_recommendation',
            serializer_class=None)
    def get_project_recommendation(self, request):
        user_id = request.GET.get('user_id', None)
        profile = Profile.objects.get(owner_id=user_id)
        exps = []
        if profile.expertise:
            exps = re.split('; |, |\n', profile.expertise)
            exps = [r.strip() for r in exps]

        """
            value of the dictionary items will be a list of length 3:
            [rating_score, requirement_score, following_score]

            The end score calculation will be the following:
            rating_score*requirement_score*following_score

            Base value for rating_score is 1, rating/10 is added to this value.
            If someone has no rating it is treated as a rating of 5.
            This is the rating of the owner of the project.

            Default score for requirement is 1 and is incremented by 1
            with each match with expertise.

            Following_score is 1.2 for the pprojects that contain members
            that the user follows, 1 otherwise.
        """

        project_score = {}

        followed_users = Following.objects.filter(from_user=user_id)
        projects = Project.objects.filter(state="open for collaborators")
        for project in projects:
            rating = get_user_rating(project.owner_id)
            scaled_rating = rating/10.0 if rating else 0.5
            project_score[project.id] = [1 + scaled_rating, 1, 1]

            members = project.members.all()
            members = [member.id for member in members]
            for followed in followed_users:
                if followed.to_user.id in members:
                    project_score[project.id][2] = 1.2
                    break

        for keyword in exps:
            projects = Project.objects.filter(
                requirements__icontains=keyword,
                state="open for collaborators")
            for project in projects:
                project_score[project.id][1] += 1

        for project_id, scores in project_score.items():
            project_score[project_id] = math.prod(scores)

        member_projects = Project.objects.filter(
            members__id__in=[user_id])
        # pop the projects that the user is a member of out of the list
        for m_project in member_projects:
            project_score.pop(m_project.id, None)

        req_projects = CollaborationRequest.objects.filter(
            from_user=user_id)
        # pop the requested projects out of the list
        for req in req_projects:
            project_score.pop(req.to_project.id, None)

        top_ids = [i for i in sorted(project_score,
                                     key=project_score.get,
                                     reverse=True)]

        preserved = Case(*[When(id=pk, then=pos)
                           for pos, pk in enumerate(top_ids)])
        projects = Project.objects.filter(id__in=top_ids).order_by(preserved)
        serializer_context = {'request': request}
        serializer = ProjectGETPublicSerializer(
            projects, many=True, context=serializer_context)
        return Response(serializer.data)
