#!/usr/bin/env bash

cat > /etc/nginx/conf.d/default.conf <<- EOF
upstream api {
    server web:8000;
}
#server {
#    server_name $DEV_DOMAIN;
#}
server {
    listen 443 ssl;
    server_name $DEV_DOMAIN;
    root /code;
    ssl_certificate /etc/nginx/fullchain.pem;
    ssl_certificate_key /etc/nginx/cert-key.pem;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;
    
    location / {
        proxy_pass http://api;
    }
}