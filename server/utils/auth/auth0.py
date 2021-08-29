from django.http import HttpRequest
from rest_framework.authentication import BaseAuthentication

from .decode_token import decode_token


class Auth0Authentication(BaseAuthentication):
    def authenticate(self, request: HttpRequest):
        decoded_data = decode_token(request.META.get("Authorization"))


# TODO: cache in redis
