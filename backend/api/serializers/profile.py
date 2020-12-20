from api.models.profile import Profile
from rest_framework import serializers
from api.serializers.publication import PublicationSerializer


class ProfileFullSerializer(serializers.ModelSerializer):
    """
    Profile serializer for owner and admin.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')
    publications = PublicationSerializer(many=True, read_only=True)

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'birthday', 'share_birthday',
                  'expertise', 'gender', 'interests', 'affiliations',
                  'share_bio', 'share_gender', 'share_affiliations',
                  'is_public', 'publications']


class ProfileBasicSerializer(serializers.ModelSerializer):
    """
    Public profile serializer for others.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')
    publications = PublicationSerializer(many=True, read_only=True)

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'birthday', 'share_birthday',
                  'expertise',
                  'gender', 'interests', 'affiliations', 'share_bio',
                  'share_gender', 'publications',
                  'share_affiliations', 'is_public']

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        if not ret['share_birthday']:
            ret['birthday'] = ""

        if not ret['share_gender']:
            ret['gender'] = ""

        if not ret['share_bio']:
            ret['bio'] = ""

        if not ret['share_affiliations']:
            ret['affiliations'] = ""

        return ret


class ProfilePrivateSerializer(serializers.ModelSerializer):
    """
    Private profile serializer.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    publications = PublicationSerializer(many=True, read_only=True)

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name',
                  'owner', 'profile_picture', 'is_public', 'publications']
