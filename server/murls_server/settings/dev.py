from .base import BASE_DIR

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    "localhost",
    "127.0.0.1",
    "ca30-2405-201-a003-c1ae-2591-ead0-2a73-97fa.ngrok.io",
]

SECRET_KEY = "django-insecure-r^_0hj4#ekqyqkx^muo@ls(8+91125b@38p9dz1a!ec7yko49v"

# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}
