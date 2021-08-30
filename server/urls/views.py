from django.shortcuts import get_object_or_404
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import (
    ListCreateAPIView,
    RetrieveUpdateDestroyAPIView,
    ListAPIView,
    RetrieveAPIView,
)

from urls.serializers import (
    UrlSerializer,
    UrlTrackSerializer,
    GraphSerializer,
    RecycleUrlSerializer,
)
from urls.models import Url, UrlTrack, RecycleUrl
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


class RecycleUrlList(ListAPIView):
    serializer_class = RecycleUrlSerializer

    def get_queryset(self):
        return RecycleUrl.objects.filter(creator=self.request.user).all()


class RecycleUrlRestore(RetrieveAPIView):
    queryset = RecycleUrl.objects.all()
    permission_classes = [IsUrlOwner]
    lookup_field = "id"

    def retrieve(self, request, *args, **kwargs):
        try:
            recycled_url = RecycleUrl.objects.get(id=self.kwargs["id"])
            Url.objects.create(
                name=recycled_url.name,
                slug=recycled_url.slug,
                shortened=recycled_url.shortened,
                location=recycled_url.location,
                creator=recycled_url.creator,
            )
            recycled_url.delete()
            return Response({"restored": True})
        except:
            return Response({"restored": False}, status=404)
