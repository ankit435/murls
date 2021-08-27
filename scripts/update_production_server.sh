#!/bin/bash

git pull origin main

cd server/

sudo systemctl stop gunicorn

source venv/bin/activate
pipenv install
python manage.py migrate

sudo systemctl start gunicorn