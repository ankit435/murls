from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView

from urls.serializers import UrlSerializer
from urls.models import Url


class UrlListCreateView(ListCreateAPIView):
    queryset = Url.objects.all()
    serializer_class = UrlSerializer


class UrlDetailBase(RetrieveUpdateDestroyAPIView):
    queryset = Url.objects.all()
    serializer_class = UrlSerializer


class UrlDetailPrimaryKey(UrlDetailBase):
    lookup_field = "pk"


class UrlDetailSlug(UrlDetailBase):
    lookup_field = "slug"
