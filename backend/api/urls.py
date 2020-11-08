from rest_framework.authtoken.views import obtain_auth_token
from django.urls import path
from django.conf.urls import url, include
from .models.example import Example
from .serializers.example import ExampleModelSerializer
from .views.example import ExampleGenericAPIView, ExampleDetailGenericAPIView
from .views.auth import register, logout_view
from .views.user import UserDetail
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('example/', ExampleGenericAPIView.as_view(queryset=Example.objects.all(),
                                                   serializer_class=ExampleModelSerializer,
                                                   lookup_field='id')),
    path('example/<int:id>', ExampleDetailGenericAPIView.as_view(queryset=Example.objects.all(),
                                                                 serializer_class=ExampleModelSerializer,
                                                                 lookup_field='id')),

    path('register/', register),
    path('auth/', obtain_auth_token, name='auth'),
    path('logout/', logout_view),
    path('reset_password/', auth_views.PasswordResetView.as_view(),
         name="reset_password"),
    path('reset_password_sent/', auth_views.PasswordResetDoneView.as_view(),
         name="password_reset_done"),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(),
         name="password_reset_confirm"),
    path('reset_password_complete/',
         auth_views.PasswordResetCompleteView.as_view(), name="password_reset_complete"),
    path('users/<int:pk>/', UserDetail.as_view()),
]
