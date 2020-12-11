from api.models.collaboration_request import CollaborationRequest
from rest_framework import serializers


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
