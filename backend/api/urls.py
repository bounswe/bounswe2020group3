from django.urls import path
from .models.example import Example
from .serializers.example import ExampleModelSerializer
from .views.example import ExampleGenericAPIView, ExampleDetailGenericAPIView

urlpatterns = [
    path('example/', ExampleGenericAPIView.as_view(queryset=Example.objects.all(),
                                                   serializer_class=ExampleModelSerializer,
                                                   lookup_field='id')),
    path('example/<int:id>', ExampleDetailGenericAPIView.as_view(queryset=Example.objects.all(),
                                                                 serializer_class=ExampleModelSerializer,
                                                                 lookup_field='id')),
]
