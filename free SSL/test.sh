#!/bin/bash 

# path to folder A
folder_A="/etc/nginx/conf.d/"

mb_file="/home/mobi.txt"


ssl_file=$domain"_ecc"

config_pc="/etc/nginx/conf.d/wqnew-pc.conf"
config_h5="/etc/nginx/conf.d/wqnew-h5.conf"
config_update="/etc/nginx/conf.d/wqnew-update.conf"



#更改config file
echo "pls put the domain here u wanna add to $config"
read -p "add domain : " domain



ssl_file=$domain"_ecc"

	# H5
config_m80="
    server{
        listen 80;
        server_name m.$domain;
        root /home/www/newkw;
        index index.html index.htm;
    }
    "

config_m443="
    server{
    listen       443 ssl;
    server_name  m.$domain;
    ssl_certificate      /root/.acme.sh/m.$ssl_file/m.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/m.$ssl_file/m.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/newkw;
        index  index.html index.htm;
    }
    }
"

#PC
config_pc80="
    server{
        listen 80;
        server_name $domain;
        root /home/www/wqpc;
        index index.html index.htm;
    }
    "

config_pc443="
    server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/$ssl_file/$domain.cer;
    ssl_certificate_key  /root/.acme.sh/$ssl_file/$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wqpc;
        index  index.html index.htm;
    }
   
"
config_pcwww="
    server{
        listen 80;
        server_name www.$domain;
        root /home/www/wqpc;
        index index.html index.htm;
    }
    "



config_pcmb="
server{
    listen       443 ssl;
    server_name  www.$domain;
    ssl_certificate      /root/.acme.sh/www.$ssl_file/www.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/www.$ssl_file/www.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wqpc;
        index  index.html index.htm;
    }

"
config_mobi="
      {
          rewrite ^ https://m.$domain"$uri";
          break;
     }
}
"


#Update
config_update80="
    server{
        listen 80;
        server_name update.$domain;
        root /home/www/wqtvupdate;
        index index.html index.htm;
    }
    "

config_update443="
    server{
    listen       443 ssl;
    server_name  update.$domain;
    ssl_certificate      /root/.acme.sh/update.$ssl_file/update.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/update.$ssl_file/update.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wqtvupdate;
        index  index.html index.htm;
    }
    }
"

#for h5
echo " ======started create SLL for domain (h5 version) : m.$domain ======"
echo "===================================================================== "
echo "===================================================================== "  
    echo "$config_m80" >> $config_h5
    nginx -s reload


    /root/.acme.sh/acme.sh --issue -d m.$domain --nginx $config_h5 --debug

    if [ $? -eq 0 ]; then
        echo "$config_m443" >> $config_h5
        echo "证书已经生成成功"
        nginx -s reload
    else
        echo "证书生成错误，请检查"
    fi

#for PC
echo " ======started create SLL for domain (PC version) : $domain ======"  
echo "===================================================================== "
echo "===================================================================== "
    echo "$config_pc80" >> $config_pc
    nginx -s reload


    /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_pc --debug

    if [ $? -eq 0 ]; then
	
    echo "$config_pc443" >> $config_pc    
	cat "$mb_file" >> $config_pc
	echo "$config_mobi" >> $config_pc
	#pc www
	echo "$config_pcwww" >> $config_pc
        /root/.acme.sh/acme.sh --issue -d www.$domain --nginx $config_pc --debug
	echo "$config_pcmb" >> $config_pc
	cat "$mb_file" >> $config_pc
	echo "$config_mobi" >> $config_pc
        echo "证书已经生成成功"
            nginx -s reload
    else
            echo "证书生成错误，请检查"
    fi
       
#for update
echo " ======started create SLL for domain (update version) : update.$domain ======"
echo "===================================================================== "
echo "===================================================================== "        
    echo "$config_update80" >> $config_update
    nginx -s reload


    /root/.acme.sh/acme.sh --issue -d update.$domain --nginx $config_update --debug

    if [ $? -eq 0 ]; then
        echo "$config_update443" >> $config_update
        echo "证书已经生成成功"
        nginx -s reload
    else
        echo "证书生成错误，请检查"
    fi



echo "m.$domain" | tr ' ' ' \n'  >> /home/admin/dm_h5.txt
echo "$domain" | tr ' ' ' \n'  >> /home/admin/dm_pc.txt  
echo "www.$domain" | tr ' ' ' \n'  >> /home/admin/dm_pc.txt 
echo "update.$domain" | tr ' ' ' \n'  >> /home/admin/dm_update.txt

