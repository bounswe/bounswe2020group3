from rest_framework import serializers

from api.models.project import Project


class ProjectSerializer(serializers.HyperlinkedModelSerializer):
    """
    Project serializer, includes also profile owner
    """

    class Meta:
        model = Project
        fields = ['name', 'description', 'requirements', 'owner',
                  'members', 'is_public']