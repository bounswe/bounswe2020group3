from rest_framework import serializers
from api.models.milestone import Milestone


class MilestoneSerializer(serializers.ModelSerializer):
    """
    Milestone serializer
    """

    class Meta:
        model = Milestone
        fields = '__all__'
