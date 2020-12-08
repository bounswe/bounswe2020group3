from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from api.models.following import Following
from api.serializers.following import FollowSerializer


class FollowingViewSet(viewsets.ModelViewSet):
    """
    ViewSet for follow.
    """

    permission_classes = (IsAuthenticatedOrReadOnly,)
    serializer_class = FollowSerializer
    queryset = Following.objects.all()
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['from_user__id', 'to_user__id']
