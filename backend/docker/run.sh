#!/bin/sh

set -e

echo "Migrate database..."
python manage.py migrate

echo "Start debug server with live reload"
exec gunicorn backend.wsgi --bind=0.0.0.0:80
