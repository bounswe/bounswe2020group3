from notifications.models import Notification
from rest_framework import serializers
from api.serializers.project import Project, ProjectSerializer
from api.serializers.profile import Profile, ProfileSerializer
from api.serializers.user import User, UserSerializer
from api.serializers.collaboration_request import CollaborationRequest, CollaborationRequestSerializer
from api.serializers.collaboration_invite import CollaborationInvite, CollaborationInviteSerializer
from api.serializers.event import Event, EventSerializer
from api.serializers.file import File, FileSerializer
from api.serializers.milestone import Milestone, MilestoneSerializer
from api.serializers.tag import Tag, TagSerializer


class GenericNotificationRelatedField(serializers.RelatedField):
    def to_representation(self, value):
        if isinstance(value, Project):
            serializer = ProjectSerializer(value)
        if isinstance(value, Profile):
            serializer = ProfileSerializer(value)
        if isinstance(value, User):
            serializer = UserSerializer(value)
        if isinstance(value, CollaborationRequest):
            serializer = CollaborationRequestSerializer(value)
        if isinstance(value, CollaborationInvite):
            serializer = CollaborationInviteSerializer(value)
        if isinstance(value, Event):
            serializer = EventSerializer(value)
        if isinstance(value, File):
            serializer = FileSerializer(value)
        if isinstance(value, Milestone):
            serializer = Milestone(value)
        if isinstance(value, Tag):
            serializer = TagSerializer(value)

        return serializer.data


class NotificationSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    action_object = GenericNotificationRelatedField(read_only=True)
    target = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = '__all__'


'''
    Notification will be consist of invite,follow,rating,updates on your projects(member, milestones, event, description)
'''