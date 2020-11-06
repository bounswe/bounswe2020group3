from rest_framework import serializers
from ..models.example import Example


class ExampleModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Example
        fields = '__all__'
