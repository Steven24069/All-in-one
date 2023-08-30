#!/bin/bash

echo "pls put the domain here u wanna add to abc.conf"
read -p "add domain :" domain

nginx_conf="/etc/nginx/conf.d/abc.conf"

sed -i '/server_name/s/;\s*$//'  $nginx_conf  #/etc/nginx/conf.d/abc.conf

sed -i "s/server_name.*/& $domain ;/" $nginx_conf

cat $nginx_conf
