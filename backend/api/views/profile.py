from rest_framework import viewsets
from rest_framework import permissions
from rest_framework.response import Response
from api.models.profile import Profile
from api.permission import IsOwnerOrReadOnly
from api.serializers.profile import ProfileFullSerializer
from api.serializers.profile import ProfileBasicSerializer
from django_filters.rest_framework import DjangoFilterBackend


class ProfileViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """

    queryset = Profile.objects.all()
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['owner__id']

    def retrieve(self, request, *args, **kwargs):
        self.a_profile = self.get_object()
        serializer = self.get_serializer(self.a_profile)
        return Response(serializer.data)

    def get_serializer_class(self):
        this_user = self.request.user
        if this_user.is_staff:
            return ProfileFullSerializer
        elif self.action == 'list':
            return ProfileBasicSerializer
        elif self.action == 'retrieve' and self.a_profile.owner != this_user:
            return ProfileBasicSerializer
        return ProfileFullSerializer

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
