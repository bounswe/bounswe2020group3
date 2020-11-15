from requests import Response
from rest_framework import viewsets
from rest_framework import permissions
from api.models.project import Project
from api.permission import IsMemberOrReadOnly
from api.serializers.project import ProjectSerializer


class ProjectViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsMemberOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
