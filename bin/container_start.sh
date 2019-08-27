#!/bin/bash

docker-compose up -d --build

# Collect static files
echo "Collect static files"
docker-compose exec application python manage.py collectstatic --noinput

# Apply database migrations
echo "Apply database migrations"
docker-compose exec application python manage.py migrate

docker-compose logs -f
