from django.shortcuts import get_object_or_404
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import (
    ListCreateAPIView,
    RetrieveUpdateDestroyAPIView,
    ListAPIView,
)

from urls.serializers import UrlSerializer, UrlTrackSerializer, GraphSerializer
from urls.models import Url, UrlTrack
from urls.permissions import IsUrlOwner, IsUrlTrackOwner
from utils.get_graph_data import get_graph_data


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
    permission_classes = [IsUrlOwner]


class UrlDetailPrimaryKey(UrlDetailBase):
    lookup_field = "pk"


class UrlDetailSlug(UrlDetailBase):
    lookup_field = "slug"


class UrlTrackDetailPrimaryKey(ListAPIView):

    serializer_class = UrlTrackSerializer
    permission_classes = [IsUrlTrackOwner]

    def get_queryset(self):
        return UrlTrack.objects.filter(url=self.kwargs["id"]).all()


class UrlTrackGraphView(ListAPIView):

    serializer_class = GraphSerializer
    permission_classes = [IsUrlTrackOwner]

    def get_queryset(self):
        return get_graph_data(
            self.kwargs["id"], self.request.query_params.get("filter")
        )
