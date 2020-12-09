from rest_framework import viewsets
from rest_framework import permissions
from api.models.profile import Profile
from api.permission import IsOwnerOrReadOnly
from api.serializers.profile import ProfileFullSerializer
from api.serializers.profile import ProfileBasicSerializer
from api.serializers.profile import ProfilePrivateSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from django.http import FileResponse
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response


class ProfileViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    parser_classes = (MultiPartParser, FormParser)
    queryset = Profile.objects.all()
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['owner__id']

    def retrieve(self, request, *args, **kwargs):
        self.accessed_profile = self.get_object()
        serializer = self.get_serializer(self.accessed_profile)
        return Response(serializer.data)

    def get_serializer_class(self):
        this_user = self.request.user
        is_get = self.action == 'retrieve'
        is_list = self.action == 'list'
        if this_user.is_staff:
            return ProfileFullSerializer
        elif is_get and self.accessed_profile.owner == this_user:
            return ProfileFullSerializer
        elif is_get and self.accessed_profile.is_public:
            return ProfileBasicSerializer
        elif is_get and not self.accessed_profile.is_public:
            return ProfilePrivateSerializer
        elif is_list:
            return ProfilePrivateSerializer
        else:
            return ProfileFullSerializer

    @action(detail=True, methods=['get'])
    def retrieve_profile_picture(self, request, pk=None):
        picture = self.get_object().profile_picture
        return FileResponse(picture)

    @action(detail=True, methods=['delete'])
    def remove_profile_picture(self, request, pk=None):
        Profile.objects.filter(id=self.get_object().id).update(
                                            profile_picture=None)
        return Response("Profile picture is removed.")

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
