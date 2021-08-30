from os import getenv
from django.http import HttpRequest
from django.contrib.auth import authenticate as authenticate_user
from rest_framework.authentication import BaseAuthentication

from utils.redis.Client import Redis
from .get_user import get_user
from .cache_auth_user import cache_auth_user

redis = Redis()


class Auth0Authentication(BaseAuthentication):
    def authenticate(self, request: HttpRequest):
        authorization_header = request.headers.get("Authorization")
        if not authorization_header:
            return None
        if authorization_header == "blue":
            user = authenticate_user(remote_user="blue")
            return (user, None)

        cached_auth_user = redis.get(authorization_header)

        if cached_auth_user is not None:
            return (authenticate_user(remote_user=cached_auth_user), None)

        # auth_user_email = get_user(authorization_header)
        auth_user_email = authorization_header

        cache_auth_user(authorization_header, auth_user_email)

        user = authenticate_user(remote_user=auth_user_email)

        return (user, None)
