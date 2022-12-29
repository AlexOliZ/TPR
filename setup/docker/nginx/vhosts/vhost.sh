#!/usr/bin/env bash

cat > /etc/nginx/conf.d/default.conf <<- EOF
upstream api {
    server web:8000;
}

server {
    listen 80;
    server_name $DEV_DOMAIN;
    return 301 https://$DEV_DOMAIN\$request_uri;
}

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

    # location ~ \.php$ {
    #     proxy_pass http://api;
    # }

    # location ~ ^/$ {
    #     proxy_pass http://api;
    # }

    # location ~ \.php$ {
    #     try_files \$uri =404;
    #     fastcgi_split_path_info ^(.+\.php)(/.+)$;
    #     fastcgi_pass web:8000;
    #     include fastcgi_params;
    #     fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    #     fastcgi_param PATH_INFO \$fastcgi_path_info;
    # }
}