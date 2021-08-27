#!/bin/bash

git pull origin main

cd server/

printf "\nNOW STOPPING gunicorn service\n"
sudo systemctl stop gunicorn

source venv/bin/activate
pipenv install
python manage.py migrate

printf "\nNOW STARTING gunicorn service\n"
sudo systemctl start gunicorn