from api.models.event import Event
from rest_framework import serializers


class EventSerializer(serializers.ModelSerializer):
    """
    Event serializer
    """
    class Meta:
        model = Event
        fields = '__all__'
