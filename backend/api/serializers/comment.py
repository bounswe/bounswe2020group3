from api.models.comment import Comment
from rest_framework import serializers


class CommentSerializer(serializers.ModelSerializer):
    """
    Comment serializer
    """
    created = serializers.DateTimeField(read_only=True)
    owner = serializers.ReadOnlyField(source='from_user.username')

    class Meta:
        model = Comment
        fields = ['id', 'created', 'comment', 'from_user', 'to_user', 'owner']


class CommentUpdateSerializer(serializers.ModelSerializer):
    """
    Comment update serializer
    """
    class Meta:
        model = Comment
        fields = ['id', 'comment']
