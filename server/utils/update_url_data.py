from threading import Thread
from django.db.models.query import QuerySet
from django.http import HttpRequest

from utils.redis.Client import Redis
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


def temporary_cache_in_redis(slug: str, location: str):
    redis = Redis()
    redis.set_with_expiry(slug, location, 60 * 60)  # cache for 1 hr


def cache_slug_in_redis(slug: str, location: str):  # configure admin
    Thread(target=temporary_cache_in_redis, args=(slug, location), daemon=True).start()
