from django.contrib.auth.models import User
from rest_framework import serializers
from api.serializers.following import FollowerSerializer,\
    IncomingFollowRequestSerializer
from api.serializers.following import FollowingSerializer

from api.serializers.profile import ProfileFullSerializer, \
    ProfileBasicSerializer, ProfilePrivateSerializer
from api.serializers.comment import CommentSerializer


class UserFullSerializer(serializers.ModelSerializer):
    """
    User serializer for admins.
    """
    profile = ProfileFullSerializer(many=True, read_only=True)
    following = FollowerSerializer(many=True)
    followers = FollowingSerializer(many=True)
    follow_requests = IncomingFollowRequestSerializer(many=True)
    comments_received = CommentSerializer(many=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'profile',
                  'following', 'followers', 'follow_requests',
                  'comments_received']


class UserBasicSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    following = FollowerSerializer(many=True)
    followers = FollowingSerializer(many=True)
    profile = ProfileBasicSerializer(many=True, read_only=True)
    comments_received = CommentSerializer(many=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile',
                  'following', 'followers', 'comments_received']


class UserPrivateSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfilePrivateSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile']
