#!/usr/bin/env bash

block="
user vagrant;
worker_processes 4;
pid /run/nginx.pid;

events {
    worker_connections 768;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    proxy_buffer_size   256k;
    proxy_buffers   4 512k;
    proxy_busy_buffers_size   512k;

    server_names_hash_bucket_size 64;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # Logging Settings
    ##

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    ##
    # Gzip Settings
    ##

    gzip on;
    gzip_disable "msie6";

    ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
"

echo "$block" > "/etc/nginx/nginx.conf"
service nginx restart
service php5-fpm restart
