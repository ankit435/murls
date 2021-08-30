from threading import Thread

from utils.redis.Client import Redis


def run_in_thread(authorization_header: str, auth_user_email: str):
    """run inside thread to store the data in background"""
    redis = Redis()
    redis.set_with_expiry(authorization_header, auth_user_email, 5 * 60)


def cache_auth_user(authorization_header: str, auth_user_email: str):
    Thread(
        target=run_in_thread, args=(authorization_header, auth_user_email), daemon=True
    ).start()
