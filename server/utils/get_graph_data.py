from datetime import timedelta
from django.db.models import QuerySet, Count
from django.db.models.functions import TruncMinute, TruncHour, TruncDate, TruncDay
from django.utils import timezone

from urls.models import UrlTrack


def get_graph_data(url_id: int, query: str):
    if not query:
        query = " "

    query = query.lower().replace(" ", "_")

    if query == "today_minute":
        return (
            QuerySet(model=UrlTrack)
            .filter(url=url_id)
            .filter(when__gte=timezone.now() - timedelta(days=1))
            .annotate(on=TruncMinute("when"))
            .values("on")
            .annotate(count=Count("id"))
            .all()
        )
    elif query == "today_hour" or query == "today":
        return (
            QuerySet(model=UrlTrack)
            .filter(url=url_id)
            .filter(when__gte=timezone.now() - timedelta(days=1))
            .annotate(on=TruncHour("when"))
            .values("on")
            .annotate(count=Count("id"))
            .all()
        )

    elif query == "last_7_days" or query == "7_days":
        return (
            QuerySet(model=UrlTrack)
            .filter(url=url_id)
            .filter(when__gte=timezone.now() - timedelta(days=7))
            .annotate(
                on=TruncDay(
                    "when",
                )
            )
            .values("on")
            .annotate(count=Count("id"))
            .all()
        )

    elif query == "last_month" or query == "last_30_days":
        return (
            QuerySet(model=UrlTrack)
            .filter(url=url_id)
            .filter(when__gte=timezone.now() - timedelta(days=30))
            .annotate(on=TruncDay("when"))
            .values("on")
            .annotate(count=Count("id"))
            .all()
        )

    elif query == "hour":
        return (
            QuerySet(model=UrlTrack)
            .filter(url=url_id)
            .annotate(on=TruncHour("when"))
            .values("on")
            .annotate(count=Count("id"))
            .all()
        )

    elif query == "day":

        return (
            QuerySet(model=UrlTrack)
            .filter(url=url_id)
            .annotate(on=TruncDay("when"))
            .values("on")
            .annotate(count=Count("id"))
            .all()
        )

    return (
        QuerySet(model=UrlTrack)
        .filter(url=url_id)
        .annotate(on=TruncDay("when"))
        .values("on")
        .annotate(count=Count("id"))
        .all()
    )
