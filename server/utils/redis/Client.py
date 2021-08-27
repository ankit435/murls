import redis
from os import getenv, environ
from typing import Union

from dotenv import load_dotenv

load_dotenv()


class Redis:
    r: redis.Redis()

    def __init__(self):
        new_redis_client = redis.Redis(
            host=getenv("REDIS_HOST"),
            port=int(getenv("REDIS_PORT")),
            password=getenv("REDIS_PASSWORD"),
        )
        self.r = new_redis_client

    def get(self, key: str):
        self.r.get(key)

    def set(self, key: str, value: Union[int, str]):
        self.r.set(key, value)
