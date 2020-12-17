#!/bin/sh

echo Starting php-fpm
exec php-fpm${PHP_VERSION} -F -O 2>&1 | logger -t "php-fpm"
