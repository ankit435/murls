from os import getenv

from .base import BASE_DIR

DEBUG = False

ALLOWED_HOSTS = []

SECRET_KEY = getenv("DJANGO_SECRET_KEY")

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": getenv("DB_NAME"),
        "USER": getenv("DB_USER"),
        "PASSWORD": getenv("DB_PASSWORD"),
        "HOST": getenv("DB_HOST", "127.0.0.1"),
        "PORT": getenv("DB_PORT"),
    }
}
