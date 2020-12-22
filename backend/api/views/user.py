from rest_framework import viewsets
from django.contrib.auth.models import User
from api.models.profile import Profile
from api.serializers.user import UserFullSerializer
from api.serializers.user import UserBasicSerializer
from api.serializers.user import UserPrivateSerializer
from rest_framework.response import Response

from api.utils import get_is_following


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    """
    This viewset automatically provides `list` and `detail` actions.
    """
    queryset = User.objects.all()

    def retrieve(self, request, *args, **kwargs):
        self.accessed_user = self.get_object()
        serializer = self.get_serializer(self.accessed_user)
        return Response(serializer.data)

    def get_serializer_class(self):
        this_user = self.request.user
        is_get = self.action == 'retrieve'
        is_list = self.action == 'list'
        if this_user.is_staff:
            return UserFullSerializer
        elif is_get:
            is_public = Profile.objects.get(owner=self.accessed_user).is_public
            is_following = get_is_following(this_user, self.accessed_user)
            if self.accessed_user == this_user:
                return UserFullSerializer
            elif is_public or is_following:
                return UserBasicSerializer
            else:
                return UserPrivateSerializer
        elif is_list:
            return UserPrivateSerializer
        else:
            return UserFullSerializer
