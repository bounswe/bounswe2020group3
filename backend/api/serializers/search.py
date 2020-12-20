from rest_framework import serializers
from api.serializers.event import EventSerializer
from api.serializers.project import ProjectGETPublicSerializer
from api.serializers.profile import ProfileBasicSerializer


class SearchSerializer(serializers.Serializer):
    keyword = serializers.CharField(min_length=3)


class SearchResponseSerializer(serializers.Serializer):
    events = EventSerializer(read_only=True, many=True)
    projects = ProjectGETPublicSerializer(read_only=True, many=True)
    profiles = ProfileBasicSerializer(read_only=True, many=True)

    class Meta:
        fields = ['events', 'projects', 'profiles']
