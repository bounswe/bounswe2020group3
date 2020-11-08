from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from api.serializers import auth
from django.contrib.auth import logout


@api_view(['POST'])
def register(request):
    """
    Logs the user in
    """
    if request.method == 'POST':
        serializer = auth.RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.create(serializer.validated_data)
        user.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def logout_view(request):
    """
    Logs the user out
    """
    logout(request)
    return Response(None, status=status.HTTP_200_OK)
