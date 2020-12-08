from api.models.collaboration_invite import CollaborationInvite
from rest_framework import serializers
from api.models.project import Project
from django.contrib.auth.models import User


class CollaborationInviteSerializer(serializers.ModelSerializer):
    """
    Collaboration serializer
    """
    to_user = serializers.ReadOnlyField(source='to_user.id')
    from_user = serializers.ReadOnlyField(source='from_user.id')

    class Meta:
        model = CollaborationInvite
        fields = '__all__'


class CollaborationInvitePOSTSerializer(serializers.ModelSerializer):
    """
    Post serializer, includes only user
    """

    class Meta:
        model = CollaborationInvite
        fields = ['to_user', 'to_project', 'message']

    def create(self, validated_data, **kwargs):
        project = Project.objects.get(id=validated_data['to_project'].id)
        to_user = User.objects.get(id=validated_data['to_user'].id)
        validated_data['to_user'] = to_user
        validated_data['to_project'] = project
        return CollaborationInvite.objects.create(**validated_data)
