from rest_framework import serializers
from api.models.tag import Tag


class TagSerializer(serializers.ModelSerializer):
    """
    Tag serializer
    """

    class Meta:
        model = Tag
        fields = '__all__'
