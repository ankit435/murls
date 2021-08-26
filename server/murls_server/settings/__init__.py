from dotenv import load_dotenv

load_dotenv()

from os import getenv

IS_DEV = getenv("IS_DEV") is not None and getenv("IS_DEV").upper() == "TRUE"

if IS_DEV:
    from .dev import *
else:
    print("Running in PRODUCTION Environment")
    from .production import *

from .base import *
