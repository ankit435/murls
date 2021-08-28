from os import getenv


def get_full_base_url():
    base_url = getenv("BASE_URL")
    if base_url is None:
        raise UserWarning("the BASE_URL for murls was not provided")
    elif not base_url.startswith("http"):
        raise UserWarning("the BASE_URL should start with http(s)://")

    return base_url


def get_base_url_host() -> str:
    full_base_url = get_full_base_url()
    return full_base_url.replace("http://", "").replace("https://", "")
