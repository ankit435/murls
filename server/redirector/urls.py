from django.urls import path

from redirector.views import redirector

urlpatterns = [path("<str:slug>", redirector, name="main-redirector")]
