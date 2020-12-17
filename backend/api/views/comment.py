from api.models.comment import Comment
from api.models.profile import Profile
from api.models.following import Following
from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from api.permission import CommentPermission
from api.serializers.comment import CommentSerializer, CommentUpdateSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from rest_framework import status
from django.db.models import Q


class CommentViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list`, `create`, `retrieve`,
    `update` and `destroy` actions.
    """
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          CommentPermission]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['to_user']

    def get_serializer_class(self):
        if self.action in ['update', 'partial_update']:
            return CommentUpdateSerializer
        else:
            return CommentSerializer

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.validated_data['from_user'] = self.request.user
        to_user = User.objects.get(
            id=serializer.validated_data['to_user'].id)
        serializer.validated_data['to_user'] = to_user

        is_public = Profile.objects.get(owner=to_user).is_public

        is_following = Following.objects. \
            filter(from_user=self.request.user,
                   to_user=to_user).exists()

        if (is_public or is_following) and \
                self.request.user.id != to_user.id:
            Comment.objects.create(**serializer.validated_data)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def retrieve(self, request, *args, **kwargs):
        self.accessed_comment = self.get_object()
        serializer = self.get_serializer(self.accessed_comment)

        to_user = self.accessed_comment.to_user
        is_public = Profile.objects.get(owner=to_user).is_public
        if self.request.user.is_anonymous:
            is_following = False
        else:
            is_following = Following.objects. \
                filter(from_user=self.request.user,
                       to_user=to_user).exists()

        if is_public or is_following or \
                self.request.user.id == to_user.id:
            return Response(serializer.data)
        else:
            return Response(data={
                'error': 'Unauthorized'
            }, status=status.HTTP_401_UNAUTHORIZED)

    def list(self, request, *args, **kwargs):
        user = request.user
        queryset = self.filter_queryset(self.get_queryset())
        if user.is_anonymous:
            queryset = queryset.filter(to_user__profile__is_public__exact=True)
        elif not user.is_staff:
            queryset = queryset. \
                       filter(Q(to_user__profile__is_public__exact=True) |
                              Q(to_user__exact=user.id) |
                              Q(to_user__followers__exact=user.id))

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
