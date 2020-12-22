from django.contrib.auth.models import User
from rest_framework import serializers

from api.serializers.profile import ProfileFullSerializer, \
    ProfileBasicSerializer, ProfilePrivateSerializer


class UserFullSerializer(serializers.ModelSerializer):
    """
    User serializer for admins.
    """
    profile = ProfileFullSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'profile']


class UserBasicSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfileBasicSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile']


class UserPrivateSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfilePrivateSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile']
