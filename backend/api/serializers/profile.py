from api.models.profile import Profile
from rest_framework import serializers


class ProfileFullSerializer(serializers.HyperlinkedModelSerializer):
    """
    Profile serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'photo_url', 'age', 'share_age', 'expertise',
                  'gender', 'interests', 'share_bio', 'share_gender',
                  'share_affiliations']


class ProfileBasicSerializer(serializers.HyperlinkedModelSerializer):
    """
    Profile serializer, includes also profile owner
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'photo_url', 'age', 'share_age', 'expertise',
                  'gender', 'interests', 'share_bio', 'share_gender',
                  'share_affiliations']

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        if not ret['share_age']:
            ret['age'] = -1

        if not ret['share_gender']:
            ret['gender'] = ""

        if not ret['share_bio']:
            ret['bio'] = ""

        if not ret['share_affiliations']:
            ret['interests'] = ""

        return ret
