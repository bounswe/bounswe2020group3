from api.models.rating import Rating
from rest_framework import serializers

from api.serializers.user import UserNotificationSerializer


class RatingSerializer(serializers.ModelSerializer):
    """
    Rating serializer
    """
    created = serializers.DateTimeField(read_only=True)

    class Meta:
        model = Rating
        fields = '__all__'


class RatingUpdateSerializer(serializers.ModelSerializer):
    """
    Rating update serializer
    """
    class Meta:
        model = Rating
        fields = ['id', 'rating']


class RatingFeedSerializer(serializers.ModelSerializer):
    """
    Rating update serializer
    """

    from_user = UserNotificationSerializer(read_only=True)
    to_user = UserNotificationSerializer(read_only=True)

    class Meta:
        model = Rating
        fields = ['id', 'rating', 'from_user', 'to_user']
