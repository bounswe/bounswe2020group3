from rest_framework import serializers
from api.models.project import Project
from api.serializers.event import EventSerializer
from api.serializers.user import UserBasicSerializer
from api.serializers.tag import TagSerializer
from api.serializers.milestone import MilestoneSerializer


class ProjectPublicSerializer(serializers.ModelSerializer):
    """
    Project serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Project
        fields = ['id', 'name', 'description', 'requirements', 'owner',
                  'is_public', 'state', 'project_type', 'due_date',
                  'event', 'tags']


class ProjectGETPublicSerializer(serializers.ModelSerializer):
    """
    Project serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    event = EventSerializer(read_only=True)
    members = UserBasicSerializer(many=True, read_only=True)
    tags = TagSerializer(many=True, read_only=True)
    milestones = MilestoneSerializer(many=True, read_only=True)

    class Meta:
        model = Project
        fields = ['id', 'name', 'description', 'requirements', 'owner',
                  'members', 'is_public', 'state', 'project_type', 'due_date',
                  'event', 'tags', 'milestones']


class ProjectPrivateSerializer(serializers.ModelSerializer):
    """
    Project serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    tags = TagSerializer(many=True, read_only=True)

    class Meta:
        model = Project
        fields = ['id', 'name', 'description', 'owner',
                  'project_type', 'tags', 'is_public',
                  'state']
