from django.contrib.auth.models import User
from api.models.profile import Profile
from rest_framework import serializers
from django.utils.translation import gettext_lazy as _


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


class AuthTokenSerializer(serializers.Serializer):
    username = serializers.CharField(
        label=_("Username"),
        write_only=True
    )
    password = serializers.CharField(
        label=_("Password"),
        style={'input_type': 'password'},
        trim_whitespace=False,
        write_only=True
    )
    token = serializers.CharField(
        label=_("Token"),
        read_only=True
    )

    def authenticate_email(self, email: str, password: str):
        """ Authenticate a user based on username. """
        try:
            user = User.objects.get(email=email)
            if user.check_password(password):
                return user
        except Exception:
            return None

    def authenticate_username(self, username: str, password: str):
        """ Authenticate a user based on email address. """
        try:
            user = User.objects.get(username=username)
            if user.check_password(password):
                return user
        except Exception:
            return None

    def validate(self, attrs):
        username = attrs.get('username')
        password = attrs.get('password')

        if username and password:
            user = self.authenticate_username(
                username=username, password=password)
            if not user:
                user = self.authenticate_email(
                    email=username, password=password)

            # The authenticate call simply returns None for is_active=False
            # users. (Assuming the default ModelBackend authentication
            # backend.)
            if not user:
                msg = _('Unable to log in with provided credentials.')
                raise serializers.ValidationError(msg, code='authorization')
        else:
            msg = _('Must include "username" and "password".')
            raise serializers.ValidationError(msg, code='authorization')

        attrs['user'] = user
        return attrs
