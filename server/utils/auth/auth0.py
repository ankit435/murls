from os import getenv
from django.http import HttpRequest
from rest_framework.authentication import BaseAuthentication


class Auth0Authentication(BaseAuthentication):
    def authenticate(self, request: HttpRequest):
        return ({"done": True}, None)


# TODO: cache in redis
