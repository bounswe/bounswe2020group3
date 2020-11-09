from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from api.serializers import auth
from django.contrib.auth import logout
from rest_framework import generics


class RegisterGenericAPIView(generics.GenericAPIView):
    serializer_class = auth.RegisterSerializer

    def post(self, request, *args, **kwargs):
        """
        Registers a new user
        """
        serializer = auth.RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.create(serializer.validated_data)
        user.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)


class LogoutGenericAPIView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        """
        Logs the user out, has to be authenticated
        """
        logout(request)
        return Response(None, status=status.HTTP_200_OK)
