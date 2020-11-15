from rest_framework import generics, viewsets
from rest_framework import permissions
from api.models.tag import Tag
from api.serializers.tag import TagSerializer
from api.permission import IsMemberOrReadOnly


class TagViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
