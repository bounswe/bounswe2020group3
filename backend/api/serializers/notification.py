from notifications.models import Notification
from rest_framework import serializers


class NotificationSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """

    class Meta:
        model = Notification
        fields = '__all__'
