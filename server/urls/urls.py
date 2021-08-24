from django.urls import path

from urls.views import URLView

urlpatterns = [path("urls", URLView.as_view(), name="URLs")]
