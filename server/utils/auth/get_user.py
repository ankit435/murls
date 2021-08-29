from os import getenv
from urllib import request

AUTH0_DOMAIN = getenv("AUTHO_DOMAIN", "murls1.jp.auth0.com")


def get_user(auth: str):
    current_request = request.Request(
        "https://" + AUTH0_DOMAIN + "/userinfo",
        headers={"Authorization": "Bearer: YjHIkhENHaFQINNUosfwV6t22tVoyBa6"},
    )

    resp = request.urlopen(current_request)

    print("the response was ", resp.read().decode("utf-8"))


get_user("afdsa")
