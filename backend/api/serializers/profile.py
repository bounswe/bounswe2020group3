from api.models.profile import Profile
from rest_framework import serializers


class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    """
    Profile serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Profile
        fields = ['name', 'middle_name', 'last_name', 'owner',
                  'bio', 'photo_url', 'age', 'share_age', 'expertise', 'gender', 'interests']