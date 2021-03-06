from django.http import HttpResponseRedirect

from urls.models import Url, UrlTrack
from utils.redis.Client import Redis
from utils.update_url_data import update_url_data

redis = Redis()


def redirector(request, slug):

    cached_location = redis.get(slug)
    update_url_data(request, slug)

    if cached_location is not None:
        return HttpResponseRedirect(cached_location.decode('utf-8'))

    try:
        found_url = Url.objects.values("location").get(slug=slug)
        location = found_url.get("location")
        return HttpResponseRedirect(location)
    except:
        return HttpResponseRedirect("/")
