from django.apps import AppConfig

class UrlsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "urls"

    def ready(self):
        import urls.signals
        from utils.delete_expired_urls import start_scheduler
        start_scheduler()
