from django.db.models.signals import post_save, post_delete, pre_save
from django.dispatch import receiver

from urls.models import Url, RecycleUrl
from utils.redis.Client import Redis
from utils.generate_random_string import generate_random_string
from utils.base_url import get_full_base_url

redis = Redis()


@receiver(pre_save, sender=Url)
def add_slug(sender, instance, **kwargs):

    if bool(instance.slug):
        return

    generated_slug = generate_random_string()

    while Url.objects.filter(slug=generated_slug).exists():
        generated_slug = generate_random_string()

    instance.slug = generated_slug


@receiver(pre_save, sender=Url)
def add_shortened(sender, instance, **kwargs):
    full_base_url = get_full_base_url()
    instance.shortened = "{}/{}".format(full_base_url, instance.slug)


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


@receiver(post_delete, sender=Url)
def recycle_url(sender, instance, **kwargs):
    RecycleUrl.objects.create(
        name=instance.name,
        slug=instance.slug,
        shortened=instance.shortened,
        location=instance.location,
        creator=instance.creator,
    )
