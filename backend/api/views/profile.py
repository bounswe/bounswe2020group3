from rest_framework import viewsets
from rest_framework import permissions
from api.models.profile import Profile
from api.permission import IsOwnerOrReadOnly
from api.serializers.profile import ProfileSerializer


class ProfileViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]