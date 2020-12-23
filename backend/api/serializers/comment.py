from api.models.comment import Comment
from rest_framework import serializers


class CommentSerializer(serializers.ModelSerializer):
    """
    Comment serializer
    """
    created = serializers.DateTimeField(read_only=True)

    class Meta:
        model = Comment
        fields = '__all__'


class CommentUpdateSerializer(serializers.ModelSerializer):
    """
    Comment update serializer
    """
    class Meta:
        model = Comment
        fields = ['id', 'comment']
