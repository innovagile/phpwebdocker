#!/bin/sh

echo Starting php-fpm
exec php-fpm7.2 -F -O 2>&1 | logger -t "php-fpm"
