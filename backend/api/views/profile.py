from rest_framework import viewsets
from rest_framework import permissions
from api.models.profile import Profile
from api.permission import IsOwnerOrReadOnly, ProfileDeletion
from api.serializers.profile import ProfileFullSerializer
from api.serializers.profile import ProfileBasicSerializer
from api.serializers.profile import ProfilePrivateSerializer
from api.serializers.profile import ProfilePictureSerializer
from django_filters.rest_framework import DjangoFilterBackend
from django.http import FileResponse
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import MultiPartParser, FormParser
from api.utils import get_is_following


class ProfileViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Profile.objects.all()
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly, ProfileDeletion]
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
        elif is_get:
            is_public = self.accessed_profile.is_public
            accessed_user = self.accessed_profile.owner
            is_following = get_is_following(this_user, accessed_user)
            if self.accessed_profile.owner == this_user:
                return ProfileFullSerializer
            elif is_public or is_following:
                return ProfileBasicSerializer
            else:
                return ProfilePrivateSerializer
        elif is_list:
            return ProfilePrivateSerializer
        else:
            return ProfileFullSerializer

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)


class ProfilePictureViewSet(viewsets.GenericViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfilePictureSerializer
    parser_classes = (MultiPartParser, FormParser)
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]

    def retrieve(self, request, pk=None):
        picture = self.get_object().profile_picture
        if picture:
            return FileResponse(picture)
        else:
            return Response("Profile picture is not found.",
                            status.HTTP_404_NOT_FOUND)

    def update(self, request, pk=None):
        data = {"profile_picture": request.data["profile_picture"]}
        profile = self.get_object()
        serializer = ProfilePictureSerializer(profile, data=data, partial=True)
        if profile.profile_picture:
            profile.profile_picture.delete()
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def destroy(self, request, pk=None):
        if self.get_object().profile_picture:
            self.get_object().profile_picture.delete()
            return Response("Profile picture is removed.", status.HTTP_200_OK)
        else:
            return Response("Profile picture is not found.",
                            status.HTTP_404_NOT_FOUND)
