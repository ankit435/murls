from django.db.models.query import QuerySet
from django.http.request import HttpRequest
from django.http import HttpResponseRedirect
from rest_framework.views import APIView
from rest_framework.response import Response

from urls.models import Url
class Redirector(APIView):
    def get(self, request:HttpRequest, slug:str)->QuerySet[Url]:
        try:
            found_url = Url.objects.values('location').get(slug=slug)
            return HttpResponseRedirect(found_url.get("location"))
        except:
            return HttpResponseRedirect('/')
        
        
