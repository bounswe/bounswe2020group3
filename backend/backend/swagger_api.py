from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework.authentication import SessionAuthentication
"""
Swagger configuration
"""
schema_view = get_schema_view(
    openapi.Info(
        title="PaperLayer API",
        default_version='v1',
        description="API documentation of PaperLayer",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
    # authentication_classes=(SessionAuthentication,),

)
