from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.authtoken.admin import User
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from api.models.following import Following, FollowRequest
from api.permission import IsRequestSenderOrReceiver
from api.serializers.following import FollowSerializer,\
    FollowRequestSerializer, FollowPostSerializer, \
    FollowRequestPostSerializer
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

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = FollowPostSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.validated_data['from_user'] = self.request.user
        to_user = User.objects.get(
            id=serializer.validated_data['to_user']['id'])
        serializer.validated_data['to_user'] = to_user
        Following.objects.create(**serializer.validated_data)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    @action(detail=True, methods=['POST'], name='unfollow',
            serializer_class=None)
    def unfollow(self, request, pk=None):

        following = get_object_or_404(
            Following, pk=pk)
        if following.to_user == self.request.user:
            following.unfollow()
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)


class FollowRequestViewSet(viewsets.ModelViewSet):
    """
    ViewSet for follow request.
    """

    permission_classes = (IsAuthenticatedOrReadOnly,
                          IsRequestSenderOrReceiver)
    queryset = FollowRequest.objects.all()
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['req_to_user']

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = FollowRequestPostSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.validated_data['req_from_user'] = self.request.user
        to_user = User.objects.get(
            id=serializer.validated_data['req_to_user']['id'])
        serializer.validated_data['req_to_user'] = to_user
        FollowRequest.objects.create(**serializer.validated_data)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def get_serializer_class(self):
        if self.action == 'create':
            return FollowRequestPostSerializer
        return FollowRequestSerializer
    
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
    def reject_follow(self, request, pk):

        follow_request = get_object_or_404(
            FollowRequest, pk=pk)
        if follow_request.req_to_user == self.request.user:
            follow_request.reject()
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)
