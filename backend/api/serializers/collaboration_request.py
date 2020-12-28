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
