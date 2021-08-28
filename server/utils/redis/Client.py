import redis
from os import getenv, environ
from typing import Union


class Redis:
    r: redis.Redis()

    def __init__(self):
        new_redis_client = redis.Redis(
            host=getenv("REDIS_HOST"),
            port=int(getenv("REDIS_PORT")),
            password=getenv("REDIS_PASSWORD"),
        )
        self.r = new_redis_client

    def get(self, key: str) -> Union[str, None]:
        return self.r.get(key)

    def set(self, key: str, value: Union[int, str]):
        self.r.set(key, value)

    def set_with_expiry(
        self, key: str, value: Union[int, str], expiry_secs: int = 60 * 60
    ):
        self.r.setex(key, expiry_secs, value)

    def remove_key(self, key: str):
        self.r.delete(key)
