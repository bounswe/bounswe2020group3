from api.models.collaboration_invite import CollaborationInvite
from rest_framework import serializers


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
