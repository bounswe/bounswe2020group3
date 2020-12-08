from api.models.collaboration_request import CollaborationRequest
from rest_framework import serializers
from api.models.project import Project


class CollaborationRequestSerializer(serializers.ModelSerializer):
    """
    Collaboration serializer
    """
    to_user = serializers.ReadOnlyField(source='to_user.id')
    from_user = serializers.ReadOnlyField(source='from_user.id')

    class Meta:
        model = CollaborationRequest
        fields = '__all__'


class CollaborationRequestPOSTSerializer(serializers.ModelSerializer):
    """
    Post serializer, includes only user
    """
    class Meta:
        model = CollaborationRequest
        fields = ['to_project', 'message']

    def create(self, validated_data, **kwargs):
        project = Project.objects.get(id=validated_data['to_project'].id)
        validated_data['to_user'] = project.owner
        validated_data['to_project'] = project
        return CollaborationRequest.objects.create(**validated_data)
