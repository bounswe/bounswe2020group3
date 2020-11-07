from django.urls import path
from .models.example import Example
from .serializers.example import ExampleModelSerializer
from .views.example import ExampleGenericAPIView, ExampleDetailGenericAPIView
from .views.profile import ProfileViewSet
from django.urls import path, include
from rest_framework.routers import DefaultRouter

# Create a router and register our viewsets with it.
router = DefaultRouter()
router.register(r'profiles', ProfileViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('example/', ExampleGenericAPIView.as_view(queryset=Example.objects.all(),
                                                   serializer_class=ExampleModelSerializer,
                                                   lookup_field='id')),
    path('example/<int:id>', ExampleDetailGenericAPIView.as_view(queryset=Example.objects.all(),
                                                                 serializer_class=ExampleModelSerializer,
                                                                 lookup_field='id')),
]
