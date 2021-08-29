from django.db.models.query import QuerySet
from django.http.request import HttpRequest
from django.http import HttpResponsePermanentRedirect
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny

from urls.models import Url
from utils.redis.Client import Redis

redis = Redis()


class Redirector(APIView):

    permission_classes = [AllowAny]
    
    def get(self, request: HttpRequest, slug: str) -> QuerySet[Url]:

        cached_location = redis.get(slug)

        if cached_location is not None:
            return HttpResponsePermanentRedirect(cached_location)

        try:
            found_url = Url.objects.values("location").get(slug=slug)
            return HttpResponsePermanentRedirect(found_url.get("location"))
        except:
            return HttpResponsePermanentRedirect("/")
