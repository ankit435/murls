from django.core.management.base import BaseCommand
from django.db.models import QuerySet
from django.contrib.auth import get_user_model

from urls.models import Url,RecycleUrl


class Command(BaseCommand):
    help = "Custom Command to Perform a Database Operation"

    def handle(self, *args, **kwargs):
        User = get_user_model()
        blue_user = User.objects.get(username="blue")
        QuerySet(model=Url).filter(creator=blue_user).filter(id__gt=144).delete()
        QuerySet(model=RecycleUrl).filter(creator=blue_user).delete()
        self.stdout.write("Deleteing those entries")
