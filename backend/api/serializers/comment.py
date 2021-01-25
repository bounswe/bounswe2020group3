from api.models.comment import Comment
from api.models.profile import Profile
from rest_framework import serializers

from api.serializers.user import UserNotificationSerializer


class CommentSerializer(serializers.ModelSerializer):
    """
    Comment serializer
    """
    created = serializers.DateTimeField(read_only=True)
    owner = serializers.ReadOnlyField(source='from_user.username')
    name = serializers.SerializerMethodField('get_name')
    middle_name = serializers.SerializerMethodField('get_middle_name')
    last_name = serializers.SerializerMethodField('get_last_name')

    class Meta:
        model = Comment
        fields = ['id', 'created', 'comment', 'from_user', 'to_user',
                  'owner', 'name', 'middle_name', 'last_name']

    def get_name(self, obj):
        profile = Profile.objects.filter(owner__exact=obj.from_user)
        is_profile_exists = profile.exists()
        if is_profile_exists:
            return profile[0].name
        else:
            return "There is no such profile."

    def get_middle_name(self, obj):
        profile = Profile.objects.filter(owner__exact=obj.from_user)
        is_profile_exists = profile.exists()
        if is_profile_exists:
            return profile[0].middle_name
        else:
            return "There is no such profile."

    def get_last_name(self, obj):
        profile = Profile.objects.filter(owner__exact=obj.from_user)
        is_profile_exists = profile.exists()
        if is_profile_exists:
            return profile[0].last_name
        else:
            return "There is no such profile."


class CommentUpdateSerializer(serializers.ModelSerializer):
    """
    Comment update serializer
    """
    class Meta:
        model = Comment
        fields = ['id', 'comment']


class CommentCreateSerializer(serializers.ModelSerializer):
    """
    Comment serializer
    """
    created = serializers.DateTimeField(read_only=True)
    owner = serializers.ReadOnlyField(source='from_user.username')

    class Meta:
        model = Comment
        fields = ['id', 'created', 'comment', 'from_user', 'to_user',
                  'owner']


class CommentFeedSerializer(serializers.ModelSerializer):
    """
    Comment update serializer
    """

    from_user = UserNotificationSerializer(read_only=True)
    to_user = UserNotificationSerializer(read_only=True)

    class Meta:
        model = Comment
        fields = ['id', 'comment', 'from_user', 'to_user']
