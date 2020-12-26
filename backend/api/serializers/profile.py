from api.models.profile import Profile
from rest_framework import serializers
from api.models.rating import Rating
from django.db.models import Avg
from api.utils import get_my_rating


class ProfileFullSerializer(serializers.HyperlinkedModelSerializer):
    """
    Profile serializer for owner and admin.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')
    rating = serializers.SerializerMethodField('get_rating')
    my_rating = serializers.SerializerMethodField('get_my_rating')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'birthday', 'share_birthday',
                  'expertise', 'gender', 'interests', 'affiliations',
                  'share_bio', 'share_gender', 'share_affiliations',
                  'is_public', 'rating', 'my_rating']

    def get_rating(self, obj):
        ratings = Rating.objects.filter(to_user__exact=obj.owner)
        rating = ratings.aggregate(Avg('rating'))
        return rating['rating__avg']

    def get_my_rating(self, obj):
        request = self.context.get("request")
        return get_my_rating(request.user, obj.owner)


class ProfileBasicSerializer(serializers.HyperlinkedModelSerializer):
    """
    Public profile serializer for others.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    email = serializers.ReadOnlyField(source='owner.email')
    rating = serializers.SerializerMethodField('get_rating')
    my_rating = serializers.SerializerMethodField('get_my_rating')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name', 'owner', 'email',
                  'bio', 'profile_picture', 'birthday', 'share_birthday',
                  'expertise',
                  'gender', 'interests', 'affiliations', 'share_bio',
                  'share_gender', 'share_affiliations',
                  'is_public', 'rating', 'my_rating']

    def get_rating(self, obj):
        ratings = Rating.objects.filter(to_user__exact=obj.owner)
        rating = ratings.aggregate(Avg('rating'))
        return rating['rating__avg']

    def get_my_rating(self, obj):
        request = self.context.get("request")
        return get_my_rating(request.user, obj.owner)

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


class ProfilePrivateSerializer(serializers.HyperlinkedModelSerializer):
    """
    Private profile serializer.
    """
    owner = serializers.ReadOnlyField(source='owner.username')
    my_rating = serializers.SerializerMethodField('get_my_rating')

    class Meta:
        model = Profile
        fields = ['id', 'name', 'middle_name', 'last_name',
                  'owner', 'profile_picture', 'is_public', 'my_rating']

    def get_my_rating(self, obj):
        request = self.context.get("request")
        return get_my_rating(request.user, obj.owner)


class ProfilePictureSerializer(serializers.ModelSerializer):
    """
    Profile serializer for owner and admin.
    """
    class Meta:
        model = Profile
        fields = ['id', 'profile_picture']
