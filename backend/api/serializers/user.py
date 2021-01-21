from django.contrib.auth.models import User
from rest_framework import serializers

from api.serializers.profile import ProfileFullSerializer, \
    ProfileBasicSerializer, ProfilePrivateSerializer

from api.utils import get_is_following, get_is_follower, \
    get_is_follow_request_sent, get_count_of_followers, \
    get_count_of_follow_requests, get_count_of_followings, \
    get_is_follow_request_received, get_count_of_publications


class UserFullSerializer(serializers.ModelSerializer):
    """
    User serializer for admins.
    """
    profile = ProfileFullSerializer(many=True, read_only=True)
    is_follower = serializers.SerializerMethodField(read_only=True)
    is_following = serializers.SerializerMethodField(read_only=True)
    is_follow_request_sent = serializers.SerializerMethodField(read_only=True)
    is_follow_request_received = serializers. \
        SerializerMethodField(read_only=True)
    count_of_followers = serializers.SerializerMethodField(read_only=True)
    count_of_followings = serializers.SerializerMethodField(read_only=True)
    count_of_follow_requests = serializers. \
        SerializerMethodField(read_only=True)
    count_of_publications = serializers.SerializerMethodField(read_only=True)

    def get_is_follower(self, obj):
        request = self.context.get("request")
        return get_is_follower(request.user, obj)

    def get_is_following(self, obj):
        request = self.context.get("request")
        return get_is_following(request.user, obj)

    def get_is_follow_request_sent(self, obj):
        request = self.context.get("request")
        return get_is_follow_request_sent(request.user, obj)

    def get_is_follow_request_received(self, obj):
        request = self.context.get("request")
        return get_is_follow_request_received(request.user, obj)

    def get_count_of_followers(self, obj):
        return get_count_of_followers(obj)

    def get_count_of_followings(self, obj):
        return get_count_of_followings(obj)

    def get_count_of_follow_requests(self, obj):
        return get_count_of_follow_requests(obj)

    def get_count_of_publications(self, obj):
        return get_count_of_publications(obj)

    class Meta:
        model = User
        fields = ['id', 'username', 'email',
                  'profile', 'is_follower', 'is_following',
                  'is_follow_request_sent', 'is_active',
                  'is_follow_request_received',
                  'count_of_followers',
                  'count_of_followings',
                  'count_of_follow_requests',
                  'count_of_publications']


class UserBasicSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfileBasicSerializer(many=True, read_only=True)
    is_follower = serializers.SerializerMethodField(read_only=True)
    is_following = serializers.SerializerMethodField(read_only=True)
    is_follow_request_sent = serializers.SerializerMethodField(read_only=True)
    is_follow_request_received = serializers. \
        SerializerMethodField(read_only=True)
    count_of_followers = serializers.SerializerMethodField(read_only=True)
    count_of_followings = serializers.SerializerMethodField(read_only=True)
    count_of_follow_requests = serializers. \
        SerializerMethodField(read_only=True)
    count_of_publications = serializers.SerializerMethodField(read_only=True)

    def get_is_follower(self, obj):
        request = self.context.get("request")
        return get_is_follower(request.user, obj)

    def get_is_following(self, obj):
        request = self.context.get("request")
        return get_is_following(request.user, obj)

    def get_is_follow_request_sent(self, obj):
        request = self.context.get("request")
        return get_is_follow_request_sent(request.user, obj)

    def get_is_follow_request_received(self, obj):
        request = self.context.get("request")
        return get_is_follow_request_received(request.user, obj)

    def get_count_of_followers(self, obj):
        return get_count_of_followers(obj)

    def get_count_of_followings(self, obj):
        return get_count_of_followings(obj)

    def get_count_of_follow_requests(self, obj):
        return get_count_of_follow_requests(obj)

    def get_count_of_publications(self, obj):
        return get_count_of_publications(obj)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile', 'is_follower',
                  'is_following', 'is_follow_request_sent',
                  'is_follow_request_received',
                  'count_of_followers',
                  'count_of_followings',
                  'count_of_follow_requests',
                  'count_of_publications']


class UserPrivateSerializer(serializers.ModelSerializer):
    """
    User serializer for users.
    """
    profile = ProfilePrivateSerializer(many=True, read_only=True)
    is_follower = serializers.SerializerMethodField(read_only=True)
    is_following = serializers.SerializerMethodField(read_only=True)
    is_follow_request_sent = serializers.SerializerMethodField(read_only=True)
    is_follow_request_received = serializers. \
        SerializerMethodField(read_only=True)
    count_of_followers = serializers.SerializerMethodField(read_only=True)
    count_of_followings = serializers.SerializerMethodField(read_only=True)
    count_of_follow_requests = serializers. \
        SerializerMethodField(read_only=True)
    count_of_publications = serializers.SerializerMethodField(read_only=True)

    def get_is_follower(self, obj):
        request = self.context.get("request")
        return get_is_follower(request.user, obj)

    def get_is_following(self, obj):
        request = self.context.get("request")
        return get_is_following(request.user, obj)

    def get_is_follow_request_sent(self, obj):
        request = self.context.get("request")
        return get_is_follow_request_sent(request.user, obj)

    def get_is_follow_request_received(self, obj):
        request = self.context.get("request")
        return get_is_follow_request_received(request.user, obj)

    def get_count_of_followers(self, obj):
        return get_count_of_followers(obj)

    def get_count_of_followings(self, obj):
        return get_count_of_followings(obj)

    def get_count_of_follow_requests(self, obj):
        return get_count_of_follow_requests(obj)

    def get_count_of_publications(self, obj):
        return get_count_of_publications(obj)

    class Meta:
        model = User
        fields = ['id', 'username', 'profile', 'is_follower',
                  'is_following', 'is_follow_request_sent',
                  'is_follow_request_received',
                  'count_of_followers',
                  'count_of_followings',
                  'count_of_follow_requests',
                  'count_of_publications']


class UserNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username']
