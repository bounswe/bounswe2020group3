from api.models.rating import Rating
from api.models.profile import Profile
from api.models.following import Following
from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from api.permission import RatingPermission
from api.serializers.rating import RatingSerializer, \
    RatingUpdateSerializer, RatingFeedSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from notifications.signals import notify
from rest_framework import status

from api.views.feed import add_activity_to_feed


class RatingViewSet(viewsets.ModelViewSet):
    """
    Users can read, update, partial_update or delete only the
    ratings that themselves created.
    """
    queryset = Rating.objects.all()
    serializer_class = RatingSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          RatingPermission]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['to_user']

    def get_serializer_class(self):
        if self.action in ['update', 'partial_update']:
            return RatingUpdateSerializer
        else:
            return RatingSerializer

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)

    def create(self, request, *args, **kwargs):
        """
        Rating can be an integer in [0,10].
        The from_user field is automatically the requesting user.
        """
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.validated_data['from_user'] = self.request.user
        to_user = User.objects.get(
            id=serializer.validated_data['to_user'].id)
        serializer.validated_data['to_user'] = to_user

        to_profile = Profile.objects.get(owner=to_user)
        is_public = to_profile.is_public

        is_following = Following.objects. \
            filter(from_user=self.request.user,
                   to_user=to_user).exists()

        if (is_public or is_following) and \
                self.request.user.id != to_user.id:
            rating = Rating.objects.create(**serializer.validated_data)

            """
                Rating Notification
            """

            notify.send(sender=self.request.user,
                        verb="rated about you",
                        recipient=to_user,
                        target=rating,
                        description="Rating"
                        )

            """
                Adds the rating to user feed.
            """

            rating_serializer = RatingFeedSerializer(rating).data
            activity_data = {'actor': str(self.request.user),
                             'verb': 'rated {} {} stars'.format(
                                 rating_serializer['to_user']['username'],
                                 rating_serializer['rating']),
                             'type': 'rating',
                             'object': rating_serializer['id'],
                             'foreign_id': 'rating:' +
                                           str(rating_serializer['id']),
                             'rating': rating_serializer,
                             }

            add_activity_to_feed(self.request.user, activity_data)

            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def list(self, request, *args, **kwargs):
        """
        Users can only see the ratings they created.
        """
        user = request.user
        queryset = self.filter_queryset(self.get_queryset())
        if user.is_anonymous:
            queryset = []
        elif not user.is_staff:
            queryset = queryset. \
                       filter(from_user__exact=user.id)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
