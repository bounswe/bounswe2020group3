from django.urls import path
from django.conf.urls import include
from rest_framework.routers import DefaultRouter

from .models.example import Example
from .serializers.example import ExampleModelSerializer
from .views.example import ExampleGenericAPIView, ExampleDetailGenericAPIView
from .views.following import FollowingViewSet
from .views.profile import ProfileViewSet
from .views.auth import RegisterGenericAPIView, LogoutGenericAPIView, AuthView
from .views.project import ProjectViewSet
from .views.milestone import MilestoneViewSet
from .views.tag import TagViewSet
from .views.user import UserViewSet
from .views.event import EventViewSet
from .views.file import FileViewSet
from django.contrib.auth import views as auth_views

router = DefaultRouter()
router.register(r'profiles', ProfileViewSet)
router.register(r'users', UserViewSet)
router.register(r'projects', ProjectViewSet)
router.register(r'milestones', MilestoneViewSet)
router.register(r'tags', TagViewSet)
router.register(r'events', EventViewSet)
router.register(r'files', FileViewSet)
router.register(r'follow', FollowingViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('example/', ExampleGenericAPIView.as_view(
         queryset=Example.objects.all(),
         serializer_class=ExampleModelSerializer,
         lookup_field='id')),
    path('example/<int:id>', ExampleDetailGenericAPIView.as_view(
         queryset=Example.objects.all(),
         serializer_class=ExampleModelSerializer,
         lookup_field='id')),

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
]
