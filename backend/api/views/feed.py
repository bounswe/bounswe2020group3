from django.contrib.auth.models import User
from rest_framework import mixins, viewsets, status

import stream
from rest_framework.decorators import action
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


class FeedSerializer(serializers.Serializer):
    user_id = serializers.IntegerField()


class FeedViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    queryset = None

    def list(self, request, *args, **kwargs):
        user_feed = self.get_feed()
        return Response(data={
            'results': user_feed.get()['results']
        })

    @action(detail=False, methods=['POST'], url_name='follow_timeline',
            serializer_class=FeedSerializer)
    def follow_timeline(self, request):
        follow_user_id = self.request.data['user_id']
        user_feed = self.get_feed()
        response = user_feed.follow('user', follow_user_id)
        return Response(data=response, status=status.HTTP_200_OK)

    @action(detail=False, methods=['POST'], url_name='unfollow_timeline',
            serializer_class=FeedSerializer)
    def unfollow_timeline(self, request):
        unfollow_user_id = self.request.data['user_id']
        user_feed = self.get_feed()
        response = user_feed.unfollow('user', unfollow_user_id)
        return Response(data=response, status=status.HTTP_200_OK)

    @action(detail=False, methods=['GET'], url_name='timeline_followers')
    def timeline_followers(self, request):
        user_feed = self.get_feed()
        response = user_feed.following()
        return Response(data=response, status=status.HTTP_200_OK)

    def get_feed(self):
        user = User.objects.get(username=self.request.user)
        return client().feed('timeline', user.id)
