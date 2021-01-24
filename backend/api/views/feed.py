from django.contrib.auth.models import User
from rest_framework import mixins, viewsets, status

import stream
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import serializers

from backend import settings


def client():
    return stream.connect(settings.STREAM_API_KEY, settings.STREAM_API_SECRET)


def add_activity_to_feed(username, activity_data):
    user = User.objects.get(username=username)
    user_feed = client().feed('user', user.id)
    user_feed.add_activity(activity_data)


def follow_admin(username):
    user = User.objects.get(username=username)
    user_feed = client().feed('timeline', user.id)
    admin_id = User.objects.get(username='admin').id
    user_feed.follow('user', admin_id)


def follow_user_timeline(username, followed_username):
    user_id = User.objects.get(username=username).id
    followed_username_id = User.objects.get(username=followed_username).id
    user_feed = client().feed('timeline', user_id)
    user_feed.follow('user', followed_username_id)


class FeedSerializer(serializers.Serializer):
    user_id = serializers.IntegerField()


class FeedViewSet(mixins.ListModelMixin, mixins.DestroyModelMixin,
                  viewsets.GenericViewSet):
    queryset = None
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        user_id = User.objects.get(username=self.request.user).id
        user_feed = client().feed('user', user_id)
        return Response(data={
            'results': user_feed.get()['results']
        })

    def destroy(self, request, *args, **kwargs):
        user_id = User.objects.get(username=self.request.user).id
        user_feed = client().feed('user', user_id)
        response = user_feed.remove_activity(self.kwargs['pk'])
        return Response(data=response, status=status.HTTP_204_NO_CONTENT)

    @action(detail=False, methods=['GET'], url_name='timeline',
            serializer_class=FeedSerializer)
    def timeline(self, request):
        user_feed = self.get_timeline()
        results = user_feed.get()['results']
        return Response(data={
            'count': len(results),
            'results': results
        }, status=status.HTTP_200_OK)

    @action(detail=False, methods=['POST'], url_name='unfollow_timeline',
            serializer_class=FeedSerializer)
    def unfollow(self, request):
        unfollow_user_id = self.request.data['user_id']
        user_feed = self.get_timeline()
        response = user_feed.unfollow('user', unfollow_user_id)
        return Response(data=response, status=status.HTTP_200_OK)

    @action(detail=False, methods=['GET'], url_name='timeline_followers')
    def followers(self, request):
        user_feed = self.get_timeline()
        response = user_feed.following()
        return Response(data=response, status=status.HTTP_200_OK)

    def get_timeline(self):
        user = User.objects.get(username=self.request.user)
        return client().feed('timeline', user.id)
