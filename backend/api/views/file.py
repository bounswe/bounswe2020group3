from rest_framework import viewsets
from rest_framework import permissions
from api.models.file import File
from api.serializers.file import FileSerializer
from api.permission import IsFileMember
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.decorators import action
from django.http import FileResponse
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from django.db.models import Q
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
                          IsFileMember]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['project']

    '''
    Custom list action for file.
    Non-admin users will not be able to see files of a project that is
    private and they are not the owner or a member.
    '''

    def list(self, request, *args, **kwargs):
        user = request.user
        queryset = self.filter_queryset(self.get_queryset())
        if user.is_anonymous:
            queryset = queryset.filter(project__is_public__exact=True)
        elif not user.is_staff:
            queryset = queryset.filter(Q(project__is_public__exact=True) |
                                       Q(project__owner__exact=user.id) |
                                       Q(project__members__exact=user.id))

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

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
