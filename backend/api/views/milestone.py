from rest_framework import generics, viewsets
from rest_framework import permissions
from api.models.milestone import Milestone
from api.serializers.milestone import MilestoneSerializer
from api.permission import IsMilestoneMemberOrReadOnly


class MilestoneViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Milestone.objects.all()
    serializer_class = MilestoneSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsMilestoneMemberOrReadOnly]
