from threading import Thread
from django.db.models.query import QuerySet
from django.http import HttpRequest

from urls.models import Url, UrlTrack


def add_url_track(request: HttpRequest, slug: str):
    try:
        url = QuerySet(model=Url).only("id").get(slug=slug)

        ip_address = ""

        if request.META.get("REMOTE_ADDR"):
            ip_address = request.META.get("REMOTE_ADDR")
        else:
            ip_address = request.META.get("HTTP_X_FORWARDED_FOR")

        QuerySet(model=UrlTrack).create(url=url, ip_address=ip_address)

    except Exception as e:
        print("got the following exception in add url track", e)
        return


def increment_url_count(slug: str):
    try:
        url = QuerySet(model=Url).get(slug=slug)
        url.clicks += 1
        url.save()

    except Exception as e:
        print("got the following exception in increment url count", e)
        return


def update_url_data(request: HttpRequest, slug: str):
    Thread(target=add_url_track, args=(request, slug), daemon=True).start()
    Thread(target=increment_url_count, kwargs={"slug": slug}, daemon=True).start()
