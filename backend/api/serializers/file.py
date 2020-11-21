from rest_framework import serializers
from api.models.file import File


class FileSerializer(serializers.HyperlinkedModelSerializer):
    """
    File serializer
    """

    class Meta:
        model = File
        fields = ['id', 'file', 'remark', 'timestamp', 'project']