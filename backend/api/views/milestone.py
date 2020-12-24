from rest_framework import viewsets
from rest_framework import permissions
from api.models.milestone import Milestone
from api.models.project import Project
from api.serializers.project import ProjectMilestonesSerializer
from api.serializers.milestone import MilestoneSerializer
from api.permission import IsMilestoneMemberOrReadOnly
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status


class MilestoneViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Milestone.objects.all()
    serializer_class = MilestoneSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsMilestoneMemberOrReadOnly]

    @action(detail=False, methods=['GET'], url_name='get_user_milestones')
    def get_user_milestones(self, request):
        username = self.request.user.username
        list_of_milestones = []
        if username:
            projects = Project.objects.filter(members__username__in=[username])
            serializer = ProjectMilestonesSerializer(projects, many=True)
            for item in serializer.data:
                for milestone in item['milestones']:
                    milestone['project_name'] = item['name']
                    list_of_milestones.append(milestone)
            list_of_milestones.sort(key=lambda x: x.get('date'))
            return Response(data={
                'result': list_of_milestones,
            }, status=status.HTTP_200_OK)
        else:
            return Response(data={
                'result': 'Not found'
            }, status=status.HTTP_404_NOT_FOUND)
