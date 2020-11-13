from api.models.event import Event
from requests import Response
from rest_framework import viewsets
from rest_framework import permissions
from rest_framework.decorators import action
from rest_framework import renderers
from api.permission import IsOwnerOrReadOnly
from api.serializers.event import EventSerializer
from rest_framework.response import Response


class EventViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]