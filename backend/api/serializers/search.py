from rest_framework import serializers
from api.serializers.event import EventSerializer
from api.serializers.project import ProjectGETPublicSerializer
from api.serializers.profile import ProfileBasicSerializer
from api.models.event import TYPE_CHOICES
from api.models.project import STATE_CHOICES

SEARCH_TYPES = ["all", "project", "profile", "event"]
SEARCH_TYPE_CHOICES = [(SEARCH_TYPES[i], str(i))
                       for i in range(len(SEARCH_TYPES))]


class SearchRequestSerializer(serializers.Serializer):
    keyword = serializers.CharField(min_length=2)
    search_type = serializers.ChoiceField(
        choices=SEARCH_TYPE_CHOICES, allow_null=True, required=False,
        default="all")

    profile_affiliations = serializers.CharField(allow_null=True,
                                                 required=False)
    profile_expertise = serializers.CharField(allow_null=True, required=False)

    event_date_after = serializers.DateField(allow_null=True, required=False)
    event_date_before = serializers.DateField(allow_null=True, required=False)
    event_deadline_after = serializers.DateField(
        allow_null=True, required=False)
    event_deadline_before = serializers.DateField(
        allow_null=True, required=False)
    event_type = serializers.ChoiceField(
        choices=TYPE_CHOICES, allow_null=True, required=False)

    project_due_date_after = serializers.DateField(
        allow_null=True, required=False)
    project_due_date_before = serializers.DateField(
        allow_null=True, required=False)
    project_event = serializers.IntegerField(allow_null=True, required=False)
    project_event_title = serializers.CharField(allow_null=True,
                                                required=False)
    project_state = serializers.ChoiceField(
        choices=STATE_CHOICES, allow_null=True, required=False)
    project_tags = serializers.ListField(
        child=serializers.IntegerField(), allow_null=True, required=False)


class SearchResponseSerializer(serializers.Serializer):
    events = EventSerializer(read_only=True, many=True)
    projects = ProjectGETPublicSerializer(read_only=True, many=True)
    profiles = ProfileBasicSerializer(read_only=True, many=True)

    class Meta:
        fields = ['events', 'projects', 'profiles']
