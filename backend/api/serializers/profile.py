from api.models.profile import Profile
from rest_framework import serializers


class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    """
    Profile serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'age', 'share_age', 'expertise',
                  'gender', 'interests', 'affiliations', 'share_bio',
                  'share_gender', 'share_affiliations']
