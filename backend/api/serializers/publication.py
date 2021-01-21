from rest_framework import serializers
from api.models.publication import Publication


class PublicationSerializer(serializers.ModelSerializer):
    """
    Publication serializer
    """

    class Meta:
        model = Publication
        fields = '__all__'
