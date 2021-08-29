from os import getenv
from django.http import HttpRequest
from django.contrib.auth import authenticate as authenticate_user
from rest_framework.authentication import BaseAuthentication

from .get_user import get_user


class Auth0Authentication(BaseAuthentication):
    def authenticate(self, request: HttpRequest):
        authorization_header = request.headers.get("Authorization")
        if not authorization_header:
            return None
        if authorization_header == "blue":
            user = authenticate_user(remote_user="blue")
            return (user, None)

        auth_user_email = get_user(authorization_header)

        user = authenticate_user(remote_user=auth_user_email)
        return (user, None)


# TODO: cache in redis
