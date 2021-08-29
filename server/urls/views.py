from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView

from urls.serializers import UrlSerializer
from urls.models import Url


class UrlListCreateView(ListCreateAPIView):
    serializer_class = UrlSerializer

    def get_queryset(self):
        return Url.objects.filter(creator=self.request.user).all()

    def perform_create(self, serializer):
        try:
            serializer.save(creator=self.request.user)
        except Exception as e:
            raise ValidationError(e)

class UrlDetailBase(RetrieveUpdateDestroyAPIView):
    queryset = Url.objects.all()
    serializer_class = UrlSerializer


class UrlDetailPrimaryKey(UrlDetailBase):
    lookup_field = "pk"


class UrlDetailSlug(UrlDetailBase):
    lookup_field = "slug"
