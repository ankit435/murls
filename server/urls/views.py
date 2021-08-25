from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import ListCreateAPIView

from urls.serializers import UrlSerializer
from urls.models import Url

class UrlView(ListCreateAPIView):
    queryset = Url.objects.all()
    serializer_class = UrlSerializer

