from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from api.serializers import auth
from django.contrib.auth import logout
from rest_framework import generics
from rest_framework import parsers, renderers
from rest_framework.authtoken.models import Token
from api.serializers.auth import AuthTokenSerializer
from rest_framework.compat import coreapi, coreschema
from rest_framework.schemas import ManualSchema
from rest_framework.schemas import coreapi as coreapi_schema
from rest_framework.views import APIView

from django.core.mail import send_mail
from django.template.loader import render_to_string
from django_email_verification.views import verify
from django.urls import get_resolver
from django.contrib.auth.tokens import default_token_generator

from api.views.feed import follow_admin


class RegisterGenericAPIView(generics.GenericAPIView):
    serializer_class = auth.RegisterSerializer

    def __send_verification(self, user: User):
        domain = 'https://paperlayer-backend.azurewebsites.net/'
        token = default_token_generator.make_token(user)

        link = ''
        for k, v in get_resolver(None).reverse_dict.items():
            if k is verify and v[0][0][1][0]:
                addr = str(v[0][0][0])
                link = domain + addr[0: addr.index('%')] + token

        text = render_to_string('verification_body.txt', {'link': link})

        for _ in range(3):
            try:
                send_mail("Confirm your PaperLayer account", text,
                          "bupazar451@gmail.com", [user.email])
                break
            except any:
                pass

    def post(self, request, *args, **kwargs):
        """
        Registers a new user
        """
        serializer = auth.RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        self.__send_verification(user)

        follow_admin(serializer.data['username'])

        return Response(serializer.data, status=status.HTTP_201_CREATED)


class LogoutGenericAPIView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        """
        Logs the user out, has to be authenticated
        """
        logout(request)
        return Response(None, status=status.HTTP_200_OK)


class AuthView(APIView):
    throttle_classes = ()
    permission_classes = ()
    parser_classes = (parsers.FormParser,
                      parsers.MultiPartParser, parsers.JSONParser,)
    renderer_classes = (renderers.JSONRenderer,)
    serializer_class = AuthTokenSerializer

    if coreapi_schema.is_enabled():
        schema = ManualSchema(
            fields=[
                coreapi.Field(
                    name="username",
                    required=True,
                    location='form',
                    schema=coreschema.String(
                        title="Username",
                        description="Valid username for authentication",
                    ),
                ),
                coreapi.Field(
                    name="password",
                    required=True,
                    location='form',
                    schema=coreschema.String(
                        title="Password",
                        description="Valid password for authentication",
                    ),
                ),
            ],
            encoding="application/json",
        )

    def get_serializer_context(self):
        return {
            'request': self.request,
            'format': self.format_kwarg,
            'view': self
        }

    def get_serializer(self, *args, **kwargs):
        kwargs['context'] = self.get_serializer_context()
        return self.serializer_class(*args, **kwargs)

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({'id': user.pk, 'token': token.key})
