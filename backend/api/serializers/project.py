from rest_framework import serializers
from api.models.project import Project


class ProjectSerializer(serializers.HyperlinkedModelSerializer):
    """
    Project serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Project
        fields = ['id','name', 'description', 'requirements', 'owner',
                  'members', 'is_public', 'state', 'project_type', 'due_date']
