from threading import Thread
from django.db.models.query import QuerySet

from urls.models import Url


def increment_url_count(slug: str, *args):

    try:
        url = QuerySet(model=Url).get(slug=slug)
        url.clicks += 1
        url.save()

    except Exception as e:
        return


def update_url_data(slug: str):
    Thread(target=increment_url_count, args=(slug), daemon=True).start()
