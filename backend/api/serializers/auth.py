from django.contrib.auth.models import User
from api.models.profile import Profile
from rest_framework import serializers


class RegisterSerializer(serializers.Serializer):
    first_name = serializers.CharField()
    middle_name = serializers.CharField(allow_blank=True)
    last_name = serializers.CharField()

    username = serializers.CharField()
    email = serializers.EmailField()
    password = serializers.CharField()

    def save(self, **kwargs):
        data = self.validated_data
        user = User.objects.create_user(data['username'], email=data['email'],
                                        password=data['password'])
        user.save()
        profile = Profile(owner=user, name=data['first_name'],
                          middle_name=data['middle_name'],
                          last_name=data['last_name'])
        profile.save()
        return user
# class LoginSerializer(serializers.Serializer):
#     username = serializers.CharField()
#     password = serializers.CharField()
