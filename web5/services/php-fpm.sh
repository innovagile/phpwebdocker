#!/bin/sh

echo Starting php-fpm
exec php-fpm5.6 -F -O 2>&1 | logger -t "php-fpm"
