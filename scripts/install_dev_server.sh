#!/bin/bash

cd server/

if [ -d venv ]
then
    printf "virtual env (venv) already present"
    printf "\nactivating ./venv\n"
    . venv/bin/activate
else
    printf "virtual not present \ncreating ./venv"
    python3 -m venv venv
    printf "\nactivating ./venv\n"
    source venv/bin/activate
    printf "\ninstall pipenv\n"
    pip install pipenv
    printf "\nnow installing dependencies\n"
    pipenv install
fi