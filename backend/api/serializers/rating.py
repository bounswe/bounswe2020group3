from api.models.rating import Rating
from rest_framework import serializers


class RatingSerializer(serializers.ModelSerializer):
    """
    Rating serializer
    """
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
