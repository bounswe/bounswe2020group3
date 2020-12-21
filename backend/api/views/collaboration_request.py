from api.models.collaboration_request import CollaborationRequest
from rest_framework import viewsets
from rest_framework import permissions
from api.serializers.collaboration_request \
    import CollaborationRequestSerializer, CollaborationRequestPOSTSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from api.permission import CollaborationPermissions
from django.shortcuts import get_object_or_404
from api.models.project import Project
from django.contrib.auth.models import User
from notifications.signals import notify


class CollaborationRequestViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = CollaborationRequest.objects.all()
    serializer_class = CollaborationRequestSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          CollaborationPermissions]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['from_user__id', 'to_user__id', 'to_project__id']

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.validated_data['from_user'] = self.request.user
        project = Project.objects.get(
            id=serializer.validated_data['to_project'].id)
        serializer.validated_data['to_user'] = project.owner
        serializer.validated_data['to_project'] = project
        if project.state == 'open for collaborators' and \
                self.request.user.id != project.owner.id:
            request = CollaborationRequest.objects.create(**serializer.validated_data)

            ''' Request Notification '''
            ''' Target --> Request '''
            user = User.objects.get(username=project.owner)
            notify.send(sender=self.request.user,
                        verb="wants to join your Project {}".format(project.name),
                        recipient=user,
                        target=request,
                        description="Request"
                        )
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    @action(detail=True, methods=['POST'], name='accept_collaboration_request',
            serializer_class=None)
    def accept_collaboration(self, request, pk=None):
        collaboration_request = get_object_or_404(
            CollaborationRequest, pk=pk)
        if collaboration_request.to_user == self.request.user:
            collaboration_request.accept()

            ''' Accept Request Notification '''
            ''' target --> Project '''
            project = Project.objects.get(id=collaboration_request.to_project_id)
            notify.send(sender=self.request.user,
                        verb="accepted your request for Project {}".format(project.name),
                        recipient=collaboration_request.from_user,
                        target=project,
                        description="Project"
                        )

            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    @action(detail=True, methods=['POST'], name='reject_collaboration_request',
            serializer_class=None)
    def reject_collaboration(self, request, pk=None):
        collaboration_request = get_object_or_404(
            CollaborationRequest, pk=pk)
        if collaboration_request.to_user == self.request.user:
            collaboration_request.reject()

            ''' Accept Request Notification '''
            ''' Target --> Project'''
            project = Project.objects.get(id=collaboration_request.to_project_id)
            notify.send(sender=self.request.user,
                        verb="rejected your request for Project {}".format(project.name),
                        recipient=collaboration_request.from_user,
                        target=project,
                        description="Project"
                        )
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return CollaborationRequestPOSTSerializer
        return super().get_serializer_class()
