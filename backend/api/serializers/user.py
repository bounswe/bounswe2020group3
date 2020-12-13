from django.contrib.auth.models import User
from rest_framework import serializers

from api.serializers.following import FollowerSerializer,\
    IncomingFollowRequestSerializer
from api.serializers.following import FollowingSerializer
from api.serializers.profile import ProfileSerializer


class UserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer(many=True, read_only=True)
    following = FollowerSerializer(many=True)
    followers = FollowingSerializer(many=True)
    follow_requests = IncomingFollowRequestSerializer(many=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'profile',
                  'following', 'followers', 'follow_requests']
