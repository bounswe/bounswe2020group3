from rest_framework import serializers
from api.models.following import Following


class FollowingSerializer(serializers.HyperlinkedModelSerializer):
    """
    Following serializer
    """

    class Meta:
        model = Following
        fields = ("id", "from_user", "created")

    def to_native(self, value):
        return self.parent.to_native(value)


class FollowerSerializer(serializers.HyperlinkedModelSerializer):
    """
    Follower serializer
    """

    class Meta:
        model = Following
        fields = ("id", "to_user", "created")

    def to_native(self, value):
        return self.parent.to_native(value)


class FollowSerializer(serializers.HyperlinkedModelSerializer):
    """
    Follow serializer
    """

    class Meta:
        model = Following
        fields = ("from_user", "to_user", "created")