from api.models.collaboration_invite import CollaborationInvite
from rest_framework import viewsets
from rest_framework import permissions
from api.serializers.collaboration_invite \
    import CollaborationInviteSerializer, CollaborationInvitePOSTSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from api.permission import CollaborationInvitePermissions
from django.shortcuts import get_object_or_404


class CollaborationInviteViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = CollaborationInvite.objects.all()
    serializer_class = CollaborationInviteSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          CollaborationInvitePermissions]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['from_user__id', 'to_user__id', 'to_project__id']

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)

    @action(detail=True, methods=['POST'], name='accept_collaboration_invite',
            serializer_class=None)
    def accept_collaboration_invite(self, request, pk=None):
        collaboration_invite = get_object_or_404(
            CollaborationInvite, pk=pk)
        if collaboration_invite.to_user == self.request.user:
            collaboration_invite.accept()
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
