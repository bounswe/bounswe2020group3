from rest_framework import viewsets
from rest_framework import permissions
from api.models.file import File
from api.serializers.file import FileSerializer
from api.permission import IsFileMemberOrReadOnly
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.decorators import action
from django.http import FileResponse


class FileViewSet(viewsets.ModelViewSet):

    parser_classes = (MultiPartParser, FormParser)
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = File.objects.all()
    serializer_class = FileSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsFileMemberOrReadOnly]

    @action(detail=True)
    def retrieve_file(self, request, pk=None):
        filename = self.get_object().file
        return FileResponse(filename)