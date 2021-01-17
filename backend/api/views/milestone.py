from rest_framework import viewsets
from rest_framework import permissions
from api.models.milestone import Milestone
from api.models.project import Project
from api.serializers.project import ProjectMilestonesSerializer
from api.serializers.milestone import MilestoneSerializer
from api.permission import IsMilestoneMemberOrReadOnly
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from django_filters.rest_framework import DjangoFilterBackend
from notifications.signals import notify
from django.contrib.auth.models import User

from api.serializers.user import UserNotificationSerializer


class MilestoneViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Milestone.objects.all()
    serializer_class = MilestoneSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsMilestoneMemberOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['project__id']

    @action(detail=False, methods=['GET'], url_name='get_user_milestones')
    def get_user_milestones(self, request, *args):
        username = self.request.user.username
        list_of_milestones = []
        if username:
            projects = Project.objects.filter(members__username__in=[username])
            serializer = ProjectMilestonesSerializer(projects, many=True)
            for item in serializer.data:
                for milestone in item['milestones']:
                    milestone['project_name'] = item['name']
                    list_of_milestones.append(milestone)
            list_of_milestones.sort(key=lambda x: x.get('date'))
            return Response(data={
                'result': list_of_milestones,
            }, status=status.HTTP_200_OK)
        else:
            return Response(data={
                'result': 'Not found'
            }, status=status.HTTP_404_NOT_FOUND)

    def dispatch(self, request, *args, **kwargs):
        response = super().dispatch(request, *args, **kwargs)
        if self.action == 'create':
            milestone = Milestone.objects.get(id=response.data['id'])
            members = UserNotificationSerializer(milestone.project.members,
                                                 many=True)
            for member in members.data:
                user = User.objects.get(id=member['id'])
                notify.send(sender=self.request.user,
                            verb="created a new Milestone with description {}".
                            format(response.data['description']),
                            recipient=user,
                            target=milestone,
                            description='Milestone')
        if self.action == 'update':
            pass
        if self.action == 'destroy':
            pass
        return response
