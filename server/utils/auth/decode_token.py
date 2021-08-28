from jose import jwt
from os import getenv
from json import loads as json_loads
from urllib.request import urlopen
from rest_framework.exceptions import AuthenticationFailed
from dotenv import load_dotenv

load_dotenv()

AUTH0_DOMAIN = getenv("AUTH0_DOMAIN")
AUTH0_ALGORITHM = getenv("AUTH0_ALGORITHM")
AUTH0_API_AUDIENCE = getenv("AUTH0_API_AUDIENCE")


def get_token_from_header(auth: str) -> str:
    """
    raise a rest_framework authenticationfailed error if token does not exist

    else return the token
    """

    if not auth:
        raise AuthenticationFailed("'Authorization' header is missing")

    parts = auth.split(" ")

    if len(parts) != 2:
        raise AuthenticationFailed(
            "'Authorization' header must be in the format 'Bearer <token>' "
        )

    if parts[0].lower() != "bearer":
        raise AuthenticationFailed("'Authorization' header must start with 'Bearer'")

    return parts[1]


def get_rsa_key(unverified_header):
    json_url_data = urlopen("https://{}/.well-known/jwks.json".format(AUTH0_DOMAIN))
    jwks = json_loads(json_url_data.read())

    for key in jwks["keys"]:
        if key["kid"] == unverified_header["kid"]:
            return {
                "kty": key["kty"],
                "kid": key["kid"],
                "use": key["use"],
                "n": key["n"],
                "e": key["e"],
            }

    return {}


def decode_token(authorization: str):
    """
    raise rest_framework authentication error if token could not be decoded

    else return the token
    """

    token = get_token_from_header(authorization)

    unverfied_header = jwt.get_unverified_header(token)

    rsa_key = get_rsa_key(unverfied_header)

    print(rsa_key,'<-- rsa_key')

    if not rsa_key:
        raise AuthenticationFailed("Unable to find the appropriate key")

    try:
        return jwt.decode(
            token,
            rsa_key,
            algorithms=[AUTH0_ALGORITHM],
            issuer="https://{}/".format(AUTH0_DOMAIN),
            audience=AUTH0_API_AUDIENCE,
        )
    except jwt.ExpiredSignatureError:
        raise AuthenticationFailed("The provided token has expired")
    except jwt.JWTClaimsError:
        raise AuthenticationFailed("The issuer or audience is invalid")
    except:
        raise AuthenticationFailed(
            "The token could not be decoded '(validation failed)'"
        )
