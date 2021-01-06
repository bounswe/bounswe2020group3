from rest_framework import viewsets
from api.serializers.notification import Notification, \
    NotificationSerializer, \
    NotificationRequestSerializer, \
    NotificationInviteSerializer, \
    NotificationProjectSerializer, \
    NotificationFollowSerializer, \
    NotificationFollowRequestSerializer, \
    NotificationMilestoneSerializer, \
    NotificationUserSerializer

from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework import status
from rest_framework import mixins
from django.shortcuts import get_object_or_404


class NotificationViewSet(viewsets.GenericViewSet,
                          mixins.ListModelMixin):
    queryset = Notification.objects.all()
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        invite_queryset = self.request.user.notifications. \
            filter(description='Invite')
        request_queryset = self.request.user.notifications. \
            filter(description='Request')
        project_queryset = self.request.user.notifications. \
            filter(description='Project')

        follow_queryset = self.request.user.notifications. \
            filter(description='Follow')

        follow_request_queryset = self.request.user.notifications. \
            filter(description='Follow Request')

        milestone_queryset = self.request.user.notifications. \
            filter(description='Milestone')

        user_queryset = self.request.user.notifications. \
            filter(description='User')

        invite_serializer = NotificationInviteSerializer(invite_queryset,
                                                         many=True)
        request_serializer = NotificationRequestSerializer(request_queryset,
                                                           many=True)

        project_serializer = NotificationProjectSerializer(project_queryset,
                                                           many=True)

        follow_serializer = NotificationFollowSerializer(follow_queryset,
                                                         many=True)
        follow_request_serializer = NotificationFollowRequestSerializer(follow_request_queryset,
                                                                        many=True)

        milestone_serializer = NotificationMilestoneSerializer(milestone_queryset,
                                                               many=True)
        user_serializer = NotificationUserSerializer(user_queryset,
                                                     many=True)

        notifications = []

        for invite in invite_serializer.data:
            notifications.append(invite)
        for request in request_serializer.data:
            notifications.append(request)
        for project in project_serializer.data:
            notifications.append(project)
        for follow in follow_serializer.data:
            notifications.append(follow)
        for follow_request in follow_request_serializer.data:
            notifications.append(follow_request)
        for milestone in milestone_serializer.data:
            notifications.append(milestone)
        for user in user_serializer.data:
            notifications.append(user)

        notifications.sort(key=lambda x: x.get('timestamp'),reverse=True)

        return Response(data={
            'count': len(notifications),
            'result': notifications
        })

    @action(detail=False, methods=['GET'], name='all notifications',
            permission_classes=[IsAdminUser])
    def admin_list_all(self, request):
        queryset = Notification.objects.all()
        serializer = NotificationSerializer(queryset, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['GET'], name='unread notifications')
    def unread(self, request):
        queryset = self.request.user.notifications.unread()
        serializer = NotificationSerializer(queryset, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['POST'],
            name='mark all notifications as read',
            serializer_class=None)
    def mark_all_as_read(self, request):
        self.request.user.notifications.mark_all_as_read()
        return Response(status=status.HTTP_200_OK)

    @action(detail=True, methods=['POST'], name='mark notification as read',
            serializer_class=None)
    def mark_as_read(self, request, pk=None):
        notification = get_object_or_404(
            Notification, recipient=self.request.user, id=pk)
        notification.mark_as_read()
        return Response(status=status.HTTP_200_OK)

    @action(detail=True, methods=['POST'], name='mark notification as unread',
            serializer_class=None)
    def mark_as_unread(self, request, pk=None):
        notification = get_object_or_404(
            Notification, recipient=self.request.user, id=pk)
        notification.mark_as_unread()
        return Response(status=status.HTTP_200_OK)

    @action(detail=True, methods=['DELETE'], name='delete notification',
            serializer_class=None)
    def delete(self, request, pk=None):
        notification = get_object_or_404(
            Notification, recipient=self.request.user, id=pk)
        notification.mark_as_unread()
        return Response(status=status.HTTP_200_OK)

    @action(detail=False, methods=['GET'],
            name='count of unread notifications',
            serializer_class=None)
    def unread_count(self, request):
        return Response(data={
            'unread_count': self.request.user.notifications.unread().count(),
        }, status=status.HTTP_200_OK)

    @action(detail=False, methods=['GET'], name='count of notifications',
            serializer_class=None)
    def all_count(self, request):
        return Response(data={
            'all_count': self.request.user.notifications.count(),
        }, status=status.HTTP_200_OK)
