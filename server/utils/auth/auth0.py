from os import getenv
from django.http import HttpRequest
from django.contrib.auth import authenticate as authenticate_user
from rest_framework.authentication import BaseAuthentication


class Auth0Authentication(BaseAuthentication):
    def authenticate(self, request: HttpRequest):
        rand = 'blue'
        user = authenticate_user(remote_user=rand)
        return (user, None)


# TODO: cache in redis
