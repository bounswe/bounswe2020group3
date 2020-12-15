from rest_framework import viewsets
from django.contrib.auth.models import User
from api.serializers.user import UserFullSerializer
from api.serializers.user import UserBasicSerializer


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    """
    This viewset automatically provides `list` and `detail` actions.
    """
    def get_serializer_class(self):
        if self.request.user.is_staff:
            return UserFullSerializer
        return UserBasicSerializer

    queryset = User.objects.all()
