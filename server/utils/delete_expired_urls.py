from django.db.models import QuerySet
from apscheduler.schedulers.background import BackgroundScheduler
from django.utils import timezone

from urls.models import Url

def delete_expired_urls():
    print('deleting some urls')
    QuerySet(model=Url).exclude(expiry_date="").filter(expiry_date__lte=timezone.now().isoformat()).delete()

def start_scheduler():
    scheduler = BackgroundScheduler()
    scheduler.add_job(delete_expired_urls, 'interval', minutes=1)
    scheduler.start()