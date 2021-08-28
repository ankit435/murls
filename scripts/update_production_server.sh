#!/bin/bash

git pull origin main

cd server/

printf "\n\nNOW STOPPING gunicorn service\n\n"
sudo systemctl stop gunicorn

source venv/bin/activate
pipenv install
python manage.py migrate

printf "\n\nNOW STARTING gunicorn service\n\n"
sudo systemctl start gunicorn