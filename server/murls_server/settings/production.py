from os import getenv

from .base import BASE_DIR

DEBUG = False

allowed_host = getenv("ALLOWED_HOST")
ALLOWED_HOSTS = ["localhost", "127.0.0.1", allowed_host]

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

REST_FRAMEWORK = {
    "DEFAULT_RENDERER_CLASSES": ("rest_framework.renderers.JSONRenderer",)
}

CSRF_COOKIE_SECURE=True

SESSION_COOKIE_SECURE=True