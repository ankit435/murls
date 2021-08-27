from django.db.models.query import QuerySet
from django.http.request import HttpRequest
from django.http import HttpResponseRedirect
from rest_framework.views import APIView
from rest_framework.response import Response

from urls.models import Url
from utils.redis.Client import Redis

redis = Redis()
class Redirector(APIView):
    def get(self, request: HttpRequest, slug: str) -> QuerySet[Url]:
        
        cached_location = redis.get(slug)
        if cached_location is not None:
            return HttpResponseRedirect(cached_location)
            
        try:
            found_url = Url.objects.values("location").get(slug=slug)
            return HttpResponseRedirect(found_url.get("location"))
        except:
            return HttpResponseRedirect("/")
