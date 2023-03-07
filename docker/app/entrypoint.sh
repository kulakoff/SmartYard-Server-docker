#!/bin/bash

cron -f -l 2 &
docker-php-entrypoint php-fpm
