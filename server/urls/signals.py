from django.db.models.signals import post_save, post_delete, pre_save
from django.dispatch import receiver

from urls.models import Url
from utils.redis.Client import Redis
from utils.generate_random_string import generate_random_string

redis = Redis()


@receiver(pre_save, sender=Url)
def add_slug(sender, instance, **kwargs):
    
    if bool(instance.slug):
        return

    generated_slug = generate_random_string()

    while Url.objects.filter(slug=generated_slug).exists():
        generated_slug = generate_random_string()

    instance.slug = generated_slug


@receiver(post_save, sender=Url)
def boost_url(sender, instance, created, **kwargs):
    if not instance.boosted and created:
        redis.set_with_expiry(instance.slug, instance.location)

    elif instance.boosted:
        redis.set(instance.slug, instance.location)

    else:  # remove boost if updated
        redis.remove_key(instance.slug)


@receiver(post_delete, sender=Url)
def unboost_url(sender, instance, **kwargs):
    redis.remove_key(instance.slug)
