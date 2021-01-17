from api.models.collaboration_invite import CollaborationInvite
from rest_framework import viewsets
from rest_framework import permissions
from api.serializers.collaboration_invite \
    import CollaborationInviteSerializer, CollaborationInvitePOSTSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from api.permission import CollaborationPermissions
from django.shortcuts import get_object_or_404
from api.models.project import Project
from django.contrib.auth.models import User
from notifications.signals import notify
from django.utils import timezone
from rest_framework.exceptions import PermissionDenied


class CollaborationInviteViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = CollaborationInvite.objects.all()
    serializer_class = CollaborationInviteSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          CollaborationPermissions]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['from_user__id', 'to_user__id', 'to_project__id']

    def create(self, request, *args, **kwargs):

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.validated_data['created'] = timezone.now()
        serializer.validated_data['from_user'] = self.request.user
        project = Project.objects.get(
            id=serializer.validated_data['to_project'].id)
        to_user = User.objects.get(id=serializer.validated_data['to_user'].id)
        serializer.validated_data['to_user'] = to_user
        serializer.validated_data['to_project'] = project
        if (project.state == 'open for collaborators' or
            project.state == 'inviting collaborators') and \
                self.request.user.id != to_user.id:
            old_invite = CollaborationInvite.objects.filter(
                from_user=self.request.user,
                to_project=project,
                to_user=to_user)
            if old_invite.count() > 0:
                raise AlreadyInvitedException(
                    status_code=status.HTTP_400_BAD_REQUEST)
            col_invite = CollaborationInvite.objects.create(
                **serializer.validated_data)
            changed_data = {'id': col_invite.id}
            changed_data.update(serializer.data)

            ''' Invite Notification '''
            ''' Target --> Invite '''
            notify.send(sender=self.request.user,
                        verb="invited you to the Project {}"
                        .format(project.name),
                        recipient=to_user,
                        target=col_invite,
                        description="Invite"
                        )

            return Response(changed_data, status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    @action(detail=True, methods=['POST'], name='accept_collaboration_invite',
            serializer_class=None)
    def accept_collaboration_invite(self, request, pk=None):
        collaboration_invite = get_object_or_404(
            CollaborationInvite, pk=pk)
        if collaboration_invite.to_user == self.request.user:
            collaboration_invite.accept()

            ''' Accept Invite Notification '''
            ''' Target --> Project'''
            project = Project.objects.get(
                id=collaboration_invite.to_project_id)
            notify.send(sender=self.request.user,
                        verb="accepted your invitation to Project {}"
                        .format(project.name),
                        recipient=collaboration_invite.from_user,
                        target=project,
                        description="Project"
                        )
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    @action(detail=True, methods=['POST'], name='reject_collaboration_invite',
            serializer_class=None)
    def reject_collaboration(self, request, pk=None):

        collaboration_invite = get_object_or_404(
            CollaborationInvite, pk=pk)
        if collaboration_invite.to_user == self.request.user:
            collaboration_invite.reject()

            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return CollaborationInvitePOSTSerializer
        return super().get_serializer_class()


class AlreadyInvitedException(PermissionDenied):
    status_code = status.HTTP_400_BAD_REQUEST
    detail = "This user has already been invited."
    status_code = 'invalid'

    def __init__(self, status_code=None):
        if status_code is not None:
            self.status_code = status_code
