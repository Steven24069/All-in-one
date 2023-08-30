#!/bin/sh
echo "请选择需要添加域名到哪个文件"
ls /etc/nginx/conf.d/
read config


#更改config file
echo "pls put the domain here u wanna add to $config"
read -p "add domain : " domain

nginx_conf="/etc/nginx/conf.d/$config"


ssl_file=$domain"_ecc"

config_content="
server{
        listen 80;
        server_name $domain;
        root /home/www/newkw;
        index index.html index.htm;
}
"
echo "$config_content" >> $nginx_conf

echo $config_content
nginx -s reload


/root/.acme.sh/acme.sh --issue -d $domain --nginx $nginx_conf --debug



config_content2="
server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/$ssl_file/$domain.cer;
    ssl_certificate_key  /root/.acme.sh/$ssl_file/$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/newkw;
        index  index.html index.htm;
    }
}
"

if [ $? -eq 0 ]; then
	echo "$config_content2" >> $nginx_conf
	echo "证书已经生成成功"
	nginx -s reload
else
	echo "证书生成错误，请检查"
fi
