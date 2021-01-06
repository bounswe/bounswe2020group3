from rest_framework import viewsets
from rest_framework import permissions
from api.permission import IsMemberOrReadOnly
from api.serializers.project import ProjectPublicSerializer
from api.serializers.project import ProjectGETPublicSerializer
from api.serializers.project import ProjectPrivateSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from notifications.signals import notify
from api.models.project import Project


class ProjectViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Project.objects.all()
    serializer_class = ProjectPublicSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsMemberOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['owner__id', 'members__id']

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user, members=[self.request.user])

    def retrieve(self, request, *args, **kwargs):
        self.accessed_project = self.get_object()
        serializer = self.get_serializer(self.accessed_project)
        return Response(serializer.data)

    def get_serializer_class(self):
        this_user = self.request.user
        is_get = self.action == 'retrieve'
        is_list = self.action == 'list'
        if this_user.is_staff:
            return ProjectGETPublicSerializer
        elif is_get and self.accessed_project.owner == this_user:
            return ProjectGETPublicSerializer
        elif is_get and this_user in self.accessed_project.members.all():
            return ProjectGETPublicSerializer
        elif is_get and self.accessed_project.is_public:
            return ProjectGETPublicSerializer
        elif is_get and not self.accessed_project.is_public:
            return ProjectPrivateSerializer
        elif is_list:
            return ProjectPrivateSerializer
        else:
            return ProjectPublicSerializer

    def dispatch(self, request, *args, **kwargs):
        response = super().dispatch(request, *args, **kwargs)
        if self.action == 'create':
            project = Project.objects.get(id=response.data['id'])
            notify.send(sender=self.request.user,
                        verb="created a new Project {}".
                        format(response.data['name']),
                        recipient=self.request.user,
                        target=project,
                        description='Project')
        if self.action == 'update':
            pass
        if self.action == 'destroy':
            pass
        return response
