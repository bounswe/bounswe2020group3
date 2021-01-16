from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.authtoken.admin import User
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from api.models.following import Following, FollowRequest
from api.permission import IsRequestSenderOrReceiver
from api.serializers.following import FollowSerializer, \
    FollowRequestSerializer, FollowPostSerializer, \
    FollowRequestPostSerializer, FollowBasicSerializer
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from rest_framework import status
from notifications.signals import notify

from api.views.feed import add_activity_to_feed


class FollowingViewSet(viewsets.ModelViewSet):
    """
    ViewSet for follow.
    """

    permission_classes = (IsAuthenticatedOrReadOnly,)
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
        follow = Following.objects.create(**serializer.validated_data)

        ''' Follow Notification '''
        ''' Target --> Follow '''
        notify.send(sender=self.request.user,
                    verb="followed you.",
                    recipient=to_user,
                    target=follow,
                    description="Follow"
                    )

        '''
            Adds the follow to the user feed
        '''
        follow_serializer = FollowBasicSerializer(follow).data
        activity_data = {'actor': str(self.request.user),
                         'verb': 'follow',
                         'object': follow_serializer['id'],
                         'foreign_id': 'follow:' +
                                       str(follow_serializer['id']),
                         'follow': follow_serializer,
                         }

        add_activity_to_feed(self.request.user, activity_data)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def get_serializer_class(self, *args, **kwargs):
        if self.action == 'create':
            return FollowPostSerializer
        return FollowSerializer

    @action(detail=True, methods=['POST'], name='unfollow',
            serializer_class=None)
    def unfollow(self, request, pk=None):

        following = get_object_or_404(
            Following, pk=pk)
        if following.from_user == self.request.user:
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
        follow_request = FollowRequest.objects.create(
            **serializer.validated_data)

        ''' Follow Request  Notification '''
        ''' Target --> Follow Request '''
        notify.send(sender=self.request.user,
                    verb="wants to follow you.",
                    recipient=to_user,
                    target=follow_request,
                    description="Follow Request"
                    )

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

            ''' Follow Request Accept Notification '''
            ''' Target --> User '''
            user = User.objects.get(id=follow_request.req_from_user)
            notify.send(sender=self.request.user,
                        verb="accepted your follow request.",
                        recipient=user,
                        target=user,
                        description="User"
                        )

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
