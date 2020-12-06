from api.models.collaboration_request import CollaborationRequest
from rest_framework import viewsets
from rest_framework import permissions
from api.serializers.collaboration_request \
    import CollaborationRequestSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from api.permission import CollaborationPermissions
from django.shortcuts import get_object_or_404


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

    @action(detail=True, methods=['POST'], name='accept_collaboration_request')
    def accept_collaboration(self, request, pk=None):

        collaboration_request = get_object_or_404(
            CollaborationRequest, pk=pk)
        collaboration_request.accept()

        return Response(status=status.HTTP_201_CREATED)

    @action(detail=True, methods=['POST'], name='reject_collaboration_request')
    def reject_collaboration(self, request, pk=None):

        collaboration_request = get_object_or_404(
            CollaborationRequest, pk=pk)
        collaboration_request.reject()

        return Response(status=status.HTTP_201_CREATED)
