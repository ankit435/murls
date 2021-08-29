from os import getenv
from urllib import request
from json import loads as json_loads
from rest_framework.exceptions import AuthenticationFailed

AUTH0_DOMAIN = getenv("AUTHO_DOMAIN", "murls1.jp.auth0.com")


def get_user(auth: str):
    print("auth = ", auth)
    try:
        current_request = request.Request(
            "https://" + AUTH0_DOMAIN + "/userinfo",
            headers={"Authorization": "Bearer {}".format(auth)},
        )

        resp = request.urlopen(current_request).read()
        data = json_loads(resp)
        return data.get("email")

    except:
        raise AuthenticationFailed("Could not get the user with the current token")
