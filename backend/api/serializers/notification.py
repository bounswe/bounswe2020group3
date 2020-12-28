from api.models.notification import Notification
from rest_framework import serializers
from api.serializers.project import Project, ProjectPrivateSerializer
from api.serializers.profile import Profile, ProfilePrivateNotificationSerializer
from api.serializers.user import User, UserPrivateSerializer
from api.serializers.collaboration_request import CollaborationRequest, \
    CollaborationRequestSerializer
from api.serializers.collaboration_invite import CollaborationInvite, \
    CollaborationInviteSerializer
from api.serializers.event import Event, EventSerializer
from api.serializers.file import File, FileSerializer
from api.serializers.milestone import Milestone, MilestoneSerializer
from api.serializers.tag import Tag, TagSerializer
from api.serializers.following import Following, FollowRequest, \
    FollowerSerializer, FollowRequestSerializer


class GenericNotificationRelatedField(serializers.RelatedField):
    def to_representation(self, value):
        if isinstance(value, Project):
            serializer = ProjectPrivateSerializer(value)
        if isinstance(value, Profile):
            serializer = ProfilePrivateNotificationSerializer(value)
        if isinstance(value, User):
            serializer = UserPrivateSerializer(value)
        if isinstance(value, CollaborationRequest):
            serializer = CollaborationRequestSerializer(value)
        if isinstance(value, CollaborationInvite):
            serializer = CollaborationInviteSerializer(value)
        if isinstance(value, Event):
            serializer = EventSerializer(value)
        if isinstance(value, File):
            serializer = FileSerializer(value)
        if isinstance(value, Milestone):
            serializer = MilestoneSerializer(value)
        if isinstance(value, Tag):
            serializer = TagSerializer(value)
        if isinstance(value, Following):
            serializer = FollowerSerializer(value)
        if isinstance(value, FollowRequest):
            serializer = FollowRequestSerializer(value)

        return serializer.data


class NotificationSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    target = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'target',
                  'unread', 'verb', 'timestamp']


class NotificationInviteSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    invite = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'invite',
                  'unread', 'verb', 'timestamp']


class NotificationRequestSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    request = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'request',
                  'unread', 'verb', 'timestamp']


class NotificationProjectSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    project = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'project',
                  'unread', 'verb', 'timestamp']


class NotificationFollowSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    following = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'following',
                  'unread', 'verb', 'timestamp']


class NotificationFollowRequestSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    follow_request = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'follow_request',
                  'unread', 'verb', 'timestamp']


class NotificationUserSerializer(serializers.ModelSerializer):
    """
    Notification serializer
    """
    actor = GenericNotificationRelatedField(read_only=True)
    recipient = GenericNotificationRelatedField(read_only=True)
    user = GenericNotificationRelatedField(read_only=True)

    class Meta:
        model = Notification
        fields = ['id', 'actor', 'description',
                  'recipient', 'user',
                  'unread', 'verb', 'timestamp']
