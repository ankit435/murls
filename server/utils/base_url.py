from os import getenv
from urllib.parse import urlparse


def get_full_base_url():
    base_url = getenv("BASE_URL")
    if base_url is None:
        raise UserWarning("the BASE_URL for murls was not provided")
    elif not base_url.startswith("http"):
        raise UserWarning("the BASE_URL should start with http(s)://")

    return base_url


def get_base_url_host():
    parsed_url = urlparse(get_full_base_url())
    return parsed_url.netloc
