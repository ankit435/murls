#!/bin/bash

cd server/

if [ -d venv ]
then
    printf "\nvirtual env (venv) already present\n"
    printf "\nactivating ./venv\n"
    . venv/bin/activate
else
    printf "\nvirtual not present \ncreating ./venv\n"
    python3 -m venv venv
    printf "\nactivating ./venv\n"
    source venv/bin/activate
    printf "\ninstall pipenv\n"
    pip install pipenv
    printf "\nnow installing dependencies\n"
    pipenv install
fi