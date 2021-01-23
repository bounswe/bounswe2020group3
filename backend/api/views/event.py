from django.contrib.auth.models import User

from api.models.event import Event
from rest_framework import viewsets
from rest_framework import permissions
from api.serializers.event import EventSerializer
from django_filters.rest_framework import DjangoFilterBackend
from api.views.feed import add_activity_to_feed


class EventViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['event_type']

    def perform_create(self, serializer):
        serializer.save()

        '''
            Adds the events to admin feed.
        '''

        admin = User.objects.get(id=1)
        id = serializer.data['id']
        activity_data = {'actor': admin.username,
                         'verb': serializer.data['title'] + ' is created.',
                         'object': id,
                         'type': 'event',
                         'foreign_id': 'event:' + str(id),
                         'event': serializer.data,
                         }
        add_activity_to_feed('admin', activity_data)
