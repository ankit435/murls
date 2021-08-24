from django.db import models

# Create your models here.
class Url(models.Model):
    name = models.CharField(blank=True, max_length=100)
    description = models.TextField(blank=True)
    location = models.URLField(max_length=256)
    boosted = models.BooleanField(verbose_name="is_boosted", default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
