from django.urls import path

from members.views import PrivateView

urlpatterns = [
    path("private", PrivateView.as_view(), name="private"),
]
