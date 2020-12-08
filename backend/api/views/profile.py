from rest_framework import viewsets
from rest_framework import permissions
from api.models.profile import Profile
from api.permission import IsOwnerOrReadOnly
from api.serializers.profile import ProfileSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from django.http import FileResponse
from rest_framework.parsers import MultiPartParser, FormParser


class ProfileViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    parser_classes = (MultiPartParser, FormParser)
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['owner__id']

    @action(detail=True)
    def retrieve_profile_picture(self, request, pk=None):
        picture = self.get_object().profile_picture
        return FileResponse(picture)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
