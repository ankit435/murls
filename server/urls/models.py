from django.db import models

from utils.generate_random_string import generate_random_string


class Url(models.Model):
    name = models.CharField(blank=True, max_length=100)
    slug = models.CharField(blank=False, unique=True, max_length=100)
    description = models.TextField(blank=True)
    location = models.URLField(max_length=2000)
    clicks = models.IntegerField(default=0, db_index=True)
    boosted = models.BooleanField(verbose_name="is_boosted", default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = generate_random_string()
        super().save(*args, **kwargs)
