from django.contrib.auth.models import User
from rest_framework import serializers


class RegisterSerializer(serializers.Serializer):
    username = serializers.CharField()
    email = serializers.CharField()
    password = serializers.CharField()

    def create(self, validated_data):
        """
        Create and return a new `User` instance, given the validated data.
        """
        return User.objects.create_user(**validated_data)

# class LoginSerializer(serializers.Serializer):
#     username = serializers.CharField()
#     password = serializers.CharField()
