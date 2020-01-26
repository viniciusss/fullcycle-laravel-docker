#!/bin/bash

cp .env.example .env

sudo chmod -R 777 storage/app
sudo chmod -R 777 storage/framework
sudo chmod -R 777 storage/logs

docker-compose build
docker-compose run --rm app composer install --no-interaction
docker-compose run --rm app php artisan key:generate
docker-compose run --rm app php artisan migrate