from rest_framework import serializers


class SearchSerializer(serializers.Serializer):
    keyword = serializers.CharField(min_length=3)
