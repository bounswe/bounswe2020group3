from api.models.report import Report
from rest_framework import permissions
from rest_framework import viewsets
from api.serializers.report import ReportSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from rest_framework import status


class ReportViewSet(viewsets.GenericViewSet):
    queryset = Report.objects.all()
    serializer_class = ReportSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['reported_user']

    def retrieve(self, request, *args, **kwargs):
        '''
        Only admins can view reports.
        '''
        user = request.user
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        if user.is_staff:
            return Response(serializer.data)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def list(self, request, *args, **kwargs):
        '''
        Only admins can view reports.
        '''
        user = request.user
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None and user.is_staff:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)

        if user.is_staff:
            return Response(serializer.data)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def destroy(self, request, *args, **kwargs):
        '''
        Only admins can delete reports.
        '''
        user = request.user
        if user.is_staff:
            instance = self.get_object()
            self.perform_destroy(instance)
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def create(self, request, *args, **kwargs):
        '''
        Only signed-in users can create reports.
        REPORT_TYPES = ["Disturbing other users",
                "Sharing unrelated or disturbing posts",
                "Spam", "Fake Profile", "Stolen Account"]
        '''
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        return Response(serializer.data,
                        status=status.HTTP_201_CREATED)

    def perform_create(self, serializer):
        serializer.save()

    def perform_destroy(self, instance):
        instance.delete()
