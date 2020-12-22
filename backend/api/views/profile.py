from rest_framework import viewsets
from rest_framework import permissions
from api.models.profile import Profile
from api.models.following import Following
from api.permission import IsOwnerOrReadOnly, ProfileDeletion
from api.serializers.profile import ProfileFullSerializer
from api.serializers.profile import ProfileBasicSerializer
from api.serializers.profile import ProfilePrivateSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.decorators import action
from django.http import FileResponse
from rest_framework.response import Response
from rest_framework import status
import os


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
            if this_user.is_anonymous:
                is_following = False
            else:
                is_following = \
                    Following.objects. \
                    filter(from_user=this_user,
                           to_user=self.accessed_profile.owner).exists()
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

    @action(detail=True, methods=['get'])
    def retrieve_profile_picture(self, request, pk=None):
        picture = self.get_object().profile_picture
        return FileResponse(picture)

    @action(detail=True, methods=['delete'])
    def remove_profile_picture(self, request, pk=None):
        if self.get_object().profile_picture:
            self.get_object().profile_picture.delete()
            return Response("Profile picture is removed.", status.HTTP_200_OK)
        else:
            return Response("Profile picture is not found.",
                            status.HTTP_404_NOT_FOUND)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data,
                                         partial=partial)
        serializer.is_valid(raise_exception=True)

        if 'profile_picture' in request.data:
            if instance.profile_picture:
                if instance.profile_picture != request.data['profile_picture']:
                    if os.path.isfile(instance.profile_picture.path):
                        os.remove(instance.profile_picture.path)

        self.perform_update(serializer)
        return Response(serializer.data)
