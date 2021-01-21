from django_email_verification import urls as mail_urls
from django.contrib import admin
from .views.rating import RatingViewSet
from .views.comment import CommentViewSet
from django.contrib.auth import views as auth_views
from .views.search import SearchGenericAPIView
from .views.notification import NotificationViewSet
from .views.publication import PublicationViewSet
from django.urls import path
from django.conf.urls import include
from rest_framework.routers import DefaultRouter
from .views.feed import FeedViewSet
from .views.following import FollowingViewSet, FollowRequestViewSet
from .views.profile import ProfileViewSet, ProfilePictureViewSet
from .views.auth import RegisterGenericAPIView, LogoutGenericAPIView, AuthView
from .views.project import ProjectViewSet
from .views.milestone import MilestoneViewSet
from .views.tag import TagViewSet
from .views.user import UserViewSet
from .views.event import EventViewSet
from .views.file import FileViewSet
from .views.collaboration_request import CollaborationRequestViewSet
from .views.collaboration_invite import CollaborationInviteViewSet

router = DefaultRouter()
router.register(r'profiles', ProfileViewSet)
router.register(r'profile_picture', ProfilePictureViewSet)
router.register(r'users', UserViewSet)
router.register(r'projects', ProjectViewSet)
router.register(r'milestones', MilestoneViewSet)
router.register(r'tags', TagViewSet)
router.register(r'events', EventViewSet)
router.register(r'files', FileViewSet)
router.register(r'follow', FollowingViewSet)
router.register(r'follow_request', FollowRequestViewSet)
router.register(r'collaboration_requests', CollaborationRequestViewSet)
router.register(r'collaboration_invites', CollaborationInviteViewSet)
router.register(r'notifications', NotificationViewSet, basename='notification')
router.register(r'comments', CommentViewSet)
router.register(r'ratings', RatingViewSet)
router.register(r'feeds', FeedViewSet, basename='feed')
router.register(r'publications', PublicationViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('register/', RegisterGenericAPIView.as_view()),
    path('auth/', AuthView.as_view(), name='auth'),
    path('logout/', LogoutGenericAPIView.as_view()),
    path('reset_password/', auth_views.PasswordResetView.as_view(),
         name="reset_password"),
    path('reset_password_sent/', auth_views.PasswordResetDoneView.as_view(),
         name="password_reset_done"),
    path('reset/<uidb64>/<token>/',
         auth_views.PasswordResetConfirmView.as_view(),
         name="password_reset_confirm"),
    path('reset_password_complete/',
         auth_views.PasswordResetCompleteView.as_view(),
         name="password_reset_complete"),
    path('admin/', admin.site.urls),
    path('email/', include(mail_urls)),
    path('search/', SearchGenericAPIView.as_view(), name='search'),

]
