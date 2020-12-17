<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="description" content="php-fpm <?= PHP_VERSION ?> + nginx docker container" />
    <title>Welcome to your site</title>
    <style>
        body {
            font-family: monospace;
        }
    </style>
    </head>
<body>
<h1>Welcome</h1>
<h3>
<?php

/*
If you're seeing this message in your browser it means that
the PHP docker container is not running properly
*/

echo 'This is a php-fpm ' . PHP_VERSION . ' + nginx docker container.';
?>
</h3>
<h4>
    <a href="https://www.innovagile.com">innovAgile - Software Development</a>
</h4>
</body>
</html>
