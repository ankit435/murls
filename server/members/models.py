from django.db import models

class Member(models.Model):
    name = models.CharField(blank=True,max_length=500)
    username = models.CharField(max_length=500)