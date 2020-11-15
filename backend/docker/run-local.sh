#!/bin/sh

set -e

echo "Migrate database..."
python manage.py migrate

echo "Start debug server with live reload"
exec python manage.py runserver 0.0.0.0:8080