from django.contrib.auth.models import User
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
    profile = serializers.HyperlinkedRelatedField(
        many=True, view_name='profile-detail', read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'profile']
