from rest_framework import serializers
from api.models.report import Report


class ReportSerializer(serializers.ModelSerializer):
    """
    Report serializer
    """

    class Meta:
        model = Report
        fields = '__all__'
