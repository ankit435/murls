from django.urls import path

from urls.views import (
    UrlListCreateView,
    UrlDetailPrimaryKey,
    UrlDetailSlug,
    UrlTrackDetailPrimaryKey,
    UrlTrackGraphView,
    RecycleUrlList,
    RecycleUrlRestore
)

urlpatterns = [
    path("urls", UrlListCreateView.as_view(), name="list-urls"),
    path("urls/<int:pk>", UrlDetailPrimaryKey.as_view(), name="url-detail-by-id"),
    path("urls/<str:slug>", UrlDetailSlug.as_view(), name="url-detail-by-id"),
    path(
        "urls/<int:id>/tracks",
        UrlTrackDetailPrimaryKey.as_view(),
        name="url-track-by-id",
    ),
    path("urls/<int:id>/graph", UrlTrackGraphView.as_view(), name="url-graph-id"),
    path("recycled-urls",RecycleUrlList.as_view(),name="recycle-url-list"),
    path("recycled-urls/<int:id>",RecycleUrlRestore.as_view(),name="recycle-url-restore")
]
