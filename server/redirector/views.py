from django.http import HttpResponsePermanentRedirect

from urls.models import Url, UrlTrack
from utils.redis.Client import Redis
from utils.update_url_data import update_url_data, cache_slug_in_redis

redis = Redis()


def redirector(request, slug):

    cached_location = redis.get(slug)
    update_url_data(request, slug)

    if cached_location is not None:
        return HttpResponsePermanentRedirect(cached_location)

    try:
        found_url = Url.objects.values("location").get(slug=slug)
        location = found_url.get("location")
        cache_slug_in_redis(slug,location)
        return HttpResponsePermanentRedirect(location)
    except:
        return HttpResponsePermanentRedirect("/")
