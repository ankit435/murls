from django.urls import path

from urls.views import UrlView

urlpatterns = [path("urls", UrlView.as_view(), name="URLs")]
