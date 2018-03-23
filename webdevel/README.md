# BeniPasss dev docker
PHP7-fpm + nginx + nodejs docker container

docker run -v $HOME/work/benipass/web:/var/www -p 8881:80 --name benipassweb --link benipassdb registry.innovagile.com:5000/benipass/webdevel
