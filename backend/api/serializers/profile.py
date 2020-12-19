from api.models.profile import Profile
from rest_framework import serializers


class ProfileFullSerializer(serializers.HyperlinkedModelSerializer):
    """
    Profile serializer for owner and admin.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'birthday', 'share_birthday',
                  'expertise', 'gender', 'interests', 'affiliations',
                  'share_bio', 'share_gender', 'share_affiliations',
                  'is_public']


class ProfileBasicSerializer(serializers.HyperlinkedModelSerializer):
    """
    Public profile serializer for others.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'birthday', 'share_birthday',
                  'expertise',
                  'gender', 'interests', 'affiliations', 'share_bio',
                  'share_gender', 'share_affiliations',
                  'is_public']

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        if not ret['share_birthday']:
            ret['birthday'] = -1

        if not ret['share_gender']:
            ret['gender'] = ""

        if not ret['share_bio']:
            ret['bio'] = ""

        if not ret['share_affiliations']:
            ret['affiliations'] = ""

        return ret


class ProfilePrivateSerializer(serializers.HyperlinkedModelSerializer):
    """
    Private profile serializer.
    """
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name',
                  'owner', 'profile_picture', 'is_public']
