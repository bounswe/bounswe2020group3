from django.contrib.auth.models import User
from rest_framework import serializers

from api.serializers.profile import ProfileFullSerializer, \
    ProfileBasicSerializer, ProfilePrivateSerializer

from api.utils import get_is_following, get_is_follower


class UserFullSerializer(serializers.ModelSerializer):
    """
    User serializer for admins.
    """
    profile = ProfileFullSerializer(many=True, read_only=True)
    is_follower = serializers.SerializerMethodField(read_only=True)
    is_following = serializers.SerializerMethodField(read_only=True)

    def get_is_follower(self, obj):
        request = self.context.get("request")
        return get_is_follower(request.user, obj)

    def get_is_following(self, obj):
        request = self.context.get("request")
        return get_is_following(request.user, obj)

    class Meta:
        model = User
        fields = ['id', 'username', 'email',
                  'profile', 'is_follower', 'is_following']


class UserBasicSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfileBasicSerializer(many=True, read_only=True)
    is_follower = serializers.SerializerMethodField(read_only=True)
    is_following = serializers.SerializerMethodField(read_only=True)

    def get_is_follower(self, obj):
        request = self.context.get("request")
        return get_is_follower(request.user, obj)

    def get_is_following(self, obj):
        request = self.context.get("request")
        return get_is_following(request.user, obj)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile', 'is_follower', 'is_following']


class UserPrivateSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfilePrivateSerializer(many=True, read_only=True)
    is_follower = serializers.SerializerMethodField(read_only=True)
    is_following = serializers.SerializerMethodField(read_only=True)

    def get_is_follower(self, obj):
        request = self.context.get("request")
        return get_is_follower(request.user, obj)

    def get_is_following(self, obj):
        request = self.context.get("request")
        return get_is_following(request.user, obj)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile', 'is_follower', 'is_following']
