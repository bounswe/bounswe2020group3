from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from api.models.following import Following, FollowRequest
from api.permission import IsRequestSenderOrReceiver
from api.serializers.following import FollowSerializer, FollowRequestSerializer
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework import status


class FollowingViewSet(viewsets.ModelViewSet):
    """
    ViewSet for follow.
    """

    permission_classes = (IsAuthenticatedOrReadOnly,)
    serializer_class = FollowSerializer
    queryset = Following.objects.all()
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['from_user__id', 'to_user__id']


class FollowRequestViewSet(viewsets.ModelViewSet):
    """
    ViewSet for follow request.
    """

    permission_classes = (IsAuthenticatedOrReadOnly,
                          IsRequestSenderOrReceiver)
    serializer_class = FollowRequestSerializer
    queryset = Following.objects.all()

    @action(detail=True, methods=['POST'], name='accept_follow_request',
            serializer_class=None)
    def accept_follow(self, request, pk=None):
        follow_request = get_object_or_404(
            FollowRequest, pk=pk)
        if follow_request.req_to_user == self.request.user:
            follow_request.accept()
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    @action(detail=True, methods=['POST'], name='reject_follow_request',
            serializer_class=None)
    def reject_follow(self, request, pk=None):

        follow_request = get_object_or_404(
            FollowRequest, pk=pk)
        if follow_request.req_to_user == self.request.user:
            follow_request.reject()
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)
