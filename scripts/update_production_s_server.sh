#!/bin/bash

cd server/

sudo systemctl stop gunicorn

pipenv install
python manage.py migrate

sudo systemctl start gunicorn