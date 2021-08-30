from django.http import HttpResponsePermanentRedirect

from urls.models import Url, UrlTrack
from utils.redis.Client import Redis
from utils.update_url_data import update_url_data

redis = Redis()


def redirector(request, slug):

    update_url_data(request, slug)
    cached_location = redis.get(slug)

    if cached_location is not None:
        return HttpResponsePermanentRedirect(cached_location)

    try:
        found_url = Url.objects.values("location").get(slug=slug)
        return HttpResponsePermanentRedirect(found_url.get("location"))
    except:
        return HttpResponsePermanentRedirect("/")
