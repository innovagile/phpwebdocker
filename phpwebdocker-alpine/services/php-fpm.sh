#!/bin/sh

echo Starting php-fpm
exec php-fpm -F -O 2>&1 | logger -t "php-fpm"
