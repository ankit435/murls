from .base import BASE_DIR

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    'localhost',
    '127.0.0.1',
    'cc9a-2405-201-a003-c1ae-d980-c3d2-3126-9dc9.ngrok.io'
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
