from rest_framework import generics
from django.contrib.auth.models import User
from api.serializers.user import UserSerializer


class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer