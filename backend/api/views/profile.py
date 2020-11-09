from requests import Response
from rest_framework import viewsets
from rest_framework import permissions
from rest_framework.decorators import action
from rest_framework import renderers
from api.models.profile import Profile
from api.permission import IsOwnerOrReadOnly
from api.serializers.profile import ProfileSerializer
from rest_framework.response import Response


class ProfileViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]

    @action(detail=True, renderer_classes=[renderers.StaticHTMLRenderer])
    def highlight(self, request, *args, **kwargs):
        snippet = self.get_object()
        return Response(snippet.highlighted)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)