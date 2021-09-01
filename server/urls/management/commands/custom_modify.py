from django.core.management.base import BaseCommand
from django.db.models import QuerySet
from django.contrib.auth import get_user_model

from urls.models import Url,RecycleUrl


class Command(BaseCommand):
    help = "Custom Command to Perform a Database Operation"

    def handle(self, *args, **kwargs):
        User = get_user_model()
        blue_user = User.objects.get(username="blue")
        a = QuerySet(model=Url).create(boosted=True,slug="murls",creator=blue_user)
        print("a = ",a)
