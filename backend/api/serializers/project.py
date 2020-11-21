from rest_framework import serializers
from api.models.project import Project
from api.serializers.event import EventSerializer


class ProjectSerializer(serializers.HyperlinkedModelSerializer):
    """
    Project serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    events = EventSerializer(many=True)

    class Meta:
        model = Project
        fields = ['name', 'description', 'requirements', 'owner',
                  'members', 'is_public', 'state', 'project_type', 'due_date',
                  'events']
