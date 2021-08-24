from os import getenv

from .base import BASE_DIR

DEBUG = False

ALLOWED_HOSTS = []

SECRET_KEY = getenv("DJANGO_SECRET_KEY")

# todo: refactor this to postgres
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}
