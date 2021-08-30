from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone


class Url(models.Model):
    name = models.CharField(blank=True, max_length=50)
    slug = models.CharField(blank=False, unique=True, max_length=100)
    shortened = models.URLField(max_length=2000)
    location = models.URLField(max_length=6000)
    clicks = models.IntegerField(default=0, db_index=True)
    boosted = models.BooleanField(verbose_name="is_boosted", default=False)
    expiry_date = models.CharField(blank=True, max_length=100)
    creator = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class UrlTrack(models.Model):
    url = models.ForeignKey(Url, on_delete=models.CASCADE)
    ip_address = models.GenericIPAddressField()
    when = models.DateTimeField(default=timezone.now)
