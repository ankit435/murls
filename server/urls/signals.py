from django.db.models.signals import post_save
from django.dispatch import receiver

from urls.models import Url
from utils.redis.Client import Redis

redis = Redis()


@receiver(post_save, sender=Url)
def boost_url(sender, instance, created, **kwargs):
    if not instance.boosted and created:
        redis.set_with_expiry(instance.slug, instance.location)

    elif instance.boosted:
        redis.set(instance.slug, instance.location)

    else: # remove boost if updated
        redis.remove_key(instance.slug)
