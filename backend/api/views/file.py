from rest_framework import viewsets
from rest_framework import permissions
from api.models.file import File
from api.serializers.file import FileSerializer
from api.permission import IsFileMemberOrReadOnly
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.decorators import action
from django.http import FileResponse
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
import os


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
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['project']

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data,
                                         partial=partial)
        serializer.is_valid(raise_exception=True)
        if os.path.isfile(instance.file.path):
            os.remove(instance.file.path)
        self.perform_update(serializer)
        return Response(serializer.data)

    @action(detail=True)
    def retrieve_file(self, request, pk=None):
        filename = self.get_object().file
        return FileResponse(filename)
