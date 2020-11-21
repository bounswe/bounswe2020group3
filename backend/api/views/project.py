from rest_framework import viewsets
from rest_framework import permissions
from api.models.project import Project
from api.permission import IsMemberOrReadOnly
from api.serializers.project import ProjectSerializer
from api.serializers.file import FileSerializer
from api.models.file import File
from django.http import JsonResponse
from rest_framework.decorators import action
from rest_framework.response import Response


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

    @action(detail=True)
    def project_files(self, request, pk=None):     
        project = self.get_object()
        projects_of_user = File.objects.filter(project=project)
        serializer_context = {
            'request': request,
        }
        file_serializer = FileSerializer(projects_of_user, context=serializer_context, many=True)
        return Response(file_serializer.data)