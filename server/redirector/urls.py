from django.urls import path

from redirector.views import Redirector

urlpatterns = [path("<str:slug>", Redirector.as_view(), name="main-redirector")]
