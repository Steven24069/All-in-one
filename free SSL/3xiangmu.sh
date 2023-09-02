#!/bin/bash

#所有项目

mb_file="/home/mobi.txt"

# Create Variables
#ss8
config_ss8_pc="/etc/nginx/conf.d/saishi8-pc.conf"
config_ss8_h5="/etc/nginx/conf.d/saishi8-h5.conf"
config_ss8_update="/etc/nginx/conf.d/saishi8-update.conf"

config_ss8="/etc/nginx/conf.d/ss8-acme.conf"

#xz

config_xz="/etc/nginx/conf.d/xz-acme.conf"

config_xz_pc="/etc/nginx/conf.d/xz-pc.conf"
config_xz_h5="/etc/nginx/conf.d/xz-h5.conf"
config_xz_update="/etc/nginx/conf.d/xz-update.conf"

#wty
config_wty="/etc/nginx/conf.d/wty-acme.conf"

config_wty_pc="/etc/nginx/conf.d/wty-pc.conf"
config_wty_h5="/etc/nginx/conf.d/wty-h5.conf"
config_wty_update="/etc/nginx/conf.d/wty-update.conf"




values=("赛事吧" "星足" "稳体育")

# In ra danh sách giá trị cùng với số thứ tự tương ứng
for i in "${!values[@]}"; do
    echo "$((i+1)). ${values[i]}"
done


#choice your project you want to do

read -p " Pls choice your project you want to update:  " choice

#

if [[ $choice -ge 1 && $choice -le ${#values[@]} ]]; then
    selected_value="${values[choice-1]}"
    echo "your choice is: $selected_value "
    
    #赛事吧
	echo "pls put the domain here u wanna add to $selected_value"
	read -p "add domain : " domain


#-------------------------------------------

ssl_file=$domain"_ecc"
####################################################################
#saishiba
        # H5
config_ss8_m80="
    server{
        listen 80;
        server_name m.$domain;
        root /home/www/saishi8-h5;
        index index.html index.htm;
    }
    "

config_ss8_m443="
    server{
    listen       443 ssl;
    server_name  m.$domain;
    ssl_certificate      /root/.acme.sh/m.$ssl_file/m.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/m.$ssl_file/m.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/saishi8-h5;
        index  index.html index.htm;
    }
    }
"

#PC
config_ss8_pc80="
    server{
        listen 80;
        server_name $domain;
        root /home/www/saishi8-pc;
        index index.html index.htm;
    }
    "

config_ss8_pc443="
    server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/$ssl_file/$domain.cer;
    ssl_certificate_key  /root/.acme.sh/$ssl_file/$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/saishi8-pc;
        index  index.html index.htm;
    }
   
"
config_ss8_pcwww="
    server{
        listen 80;
        server_name www.$domain;
        root /home/www/saishi8-pc;
        index index.html index.htm;
    }
    "



config_ss8_pcmb="
server{
    listen       443 ssl;
    server_name  www.$domain;
    ssl_certificate      /root/.acme.sh/www.$ssl_file/www.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/www.$ssl_file/www.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/saishi8-pc;
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
config_ss8_update80="
    server{
        listen 80;
        server_name update.$domain;
        root /home/www/saishi8-update;
        index index.html index.htm;
    }
    "

config_ss8_update443="
    server{
    listen       443 ssl;
    server_name  update.$domain;
    ssl_certificate      /root/.acme.sh/update.$ssl_file/update.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/update.$ssl_file/update.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/saishi8-update;
        index  index.html index.htm;
    }
    }
"
#######################################################################
#xingzu

        # H5
config_xz_m80="
    server{
        listen 80;
        server_name m.$domain;
        root /home/www/xz-h5;
        index index.html index.htm;
    }
    "

config_xz_m443="
    server{
    listen       443 ssl;
    server_name  m.$domain;
    ssl_certificate      /root/.acme.sh/m.$ssl_file/m.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/m.$ssl_file/m.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/xz-h5;
        index  index.html index.htm;
    }
    }
"

#PC
config_xz_pc80="
    server{
        listen 80;
        server_name $domain;
        root /home/www/xz-pc;
        index index.html index.htm;
    }
    "

config_xz_pc443="
    server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/$ssl_file/$domain.cer;
    ssl_certificate_key  /root/.acme.sh/$ssl_file/$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/xz-pc;
        index  index.html index.htm;
    }
   
"
config_xz_pcwww="
    server{
        listen 80;
        server_name www.$domain;
        root /home/www/xz-pc;
        index index.html index.htm;
    }
    "



config_xz_pcmb="
server{
    listen       443 ssl;
    server_name  www.$domain;
    ssl_certificate      /root/.acme.sh/www.$ssl_file/www.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/www.$ssl_file/www.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/xz-pc;
        index  index.html index.htm;
    }

"



#Update
config_xz_update80="
    server{
        listen 80;
        server_name update.$domain;
        root /home/www/xz-update;
        index index.html index.htm;
    }
    "

config_xz_update443="
    server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/update.$ssl_file/update.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/update.$ssl_file/update.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/xz-update;
        index  index.html index.htm;
    }
    }
"
######################################################################

#wentiyu
        # H5
config_wty_m80="
    server{
        listen 80;
        server_name m.$domain;
        root /home/www/wty-h5;
        index index.html index.htm;
    }
    "

config_wty_m443="
    server{
    listen       443 ssl;
    server_name  m.$domain;
    ssl_certificate      /root/.acme.sh/m.$ssl_file/m.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/m.$ssl_file/m.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wty-h5;
        index  index.html index.htm;
    }
    }
"

#PC
config_wty_pc80="
    server{
        listen 80;
        server_name $domain;
        root /home/www/wty-pc;
        index index.html index.htm;
    }
    "

config_wty_pc443="
    server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/$ssl_file/$domain.cer;
    ssl_certificate_key  /root/.acme.sh/$ssl_file/$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wty-pc;
        index  index.html index.htm;
    }
   
"
config_wty_pcwww="
    server{
        listen 80;
        server_name www.$domain;
        root /home/www/wty-pc;
        index index.html index.htm;
    }
    "



config_wty_pcmb="
server{
    listen       443 ssl;
    server_name  www.$domain;
    ssl_certificate      /root/.acme.sh/www.$ssl_file/www.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/www.$ssl_file/www.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wty-pc;
        index  index.html index.htm;
    }

"
#Update
config_wty_update80="
    server{
        listen 80;
        server_name update.$domain;
        root /home/www/wty-update;
        index index.html index.htm;
    }
    "

config_wty_update443="
    server{
    listen       443 ssl;
    server_name  update.$domain;
    ssl_certificate      /root/.acme.sh/update.$ssl_file/update.$domain.cer;
    ssl_certificate_key  /root/.acme.sh/update.$ssl_file/update.$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wty-update;
        index  index.html index.htm;
    }
    }
"













        #-------------------赛事吧---赛事吧-----
        #######################################################
        if [ $choice -eq 1 ] ;then
            #for h5
            echo " ======started create SLL for domain (h5 version) : m.$domain ======"  
            echo "$config_ss8_m80" >> $config_ss8
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d m.$domain --nginx $config_ss8 --debug

            if [ $? -eq 0 ]; then
                echo "$config_ss8_m443" >> $config_ss8
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi

            #for PC
            echo " ======started create SLL for domain (PC version) : $domain ======"  
            echo "$config_ss8_pc80 " >> $config_ss8
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_ss8 --debug

            if [ $? -eq 0 ]; then

                echo "$config_ss8_pc443" >> $config_ss8
                cat "$mb_file" >> $config_ss8
                echo "$config_mobi" >> $config_ss8
        #pc www
                echo "$config_ss8_pcwww" >> $config_ss8
                /root/.acme.sh/acme.sh --issue -d www.$domain --nginx $config_ss8 --debug
                echo "$config_ss8_pcmb" >> $config_ss8
                cat "$mb_file" >> $config_ss8
                echo "$config_mobi" >> $config_ss8
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi


            #for update
            echo " ======started create SLL for domain (update version) : update.$domain ======"        
            echo "$config_ss8_update80" >> $config_ss8
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d update.$domain --nginx $config_ss8 --debug

            if [ $? -eq 0 ]; then
                echo "$config_ss8_update443" >> $config_ss8
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi

echo "m.$domain" | tr ' ' ' \n'  >> /home/admin/list/ss8.txt
echo "$domain" | tr ' ' ' \n'  >> /home/admin/list/ss8.txt  
echo "www.$domain" | tr ' ' ' \n'  >> /home/admin/list/ss8.txt 
echo "update.$domain" | tr ' ' ' \n'  >> /home/admin/list/ss8.txt



        #-------------------星足---星足-----
        #######################################################
        elif [ $choice -eq 2 ] ;then 
            echo " ======started create SLL for domain (h5 version) : m.$domain ======"  
            echo "$config_xz_m80" >> $config_xz
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d m.$domain --nginx $config_xz --debug

            if [ $? -eq 0 ]; then
                echo "$config_xz_m443" >> $config_xz
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi

            #for PC
            echo " ======started create SLL for domain (PC version) : $domain ======"  
            echo "$config_xz_pc80" >> $config_xz
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_xz --debug

            if [ $? -eq 0 ]; then

                echo "$config_xz_pc443" >> $config_xz
                cat "$mb_file" >> $config_xz
                echo "$config_mobi" >> $config_xz
        #pc www
                echo "$config_xz_pcwww" >> $config_xz
                /root/.acme.sh/acme.sh --issue -d www.$domain --nginx $config_xz --debug
                echo "$config_xz_pcmb" >> $config_xz
                cat "$mb_file" >> $config_xz
                echo "$config_mobi" >> $config_xz
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi


            #for update
            echo " ======started create SLL for domain (update version) : update.$domain ======"        
            echo "$config_xz_update80" >> $config_xz
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d update.$domain --nginx $config_xz --debug

            if [ $? -eq 0 ]; then
                echo "$config_xz_update443" >> $config_xz
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi



echo "m.$domain" | tr ' ' ' \n'  >> /home/admin/list/xz.txt
echo "$domain" | tr ' ' ' \n'  >> /home/admin/list/xz.txt
echo "www.$domain" | tr ' ' ' \n'  >> /home/admin/list/xz.txt
echo "update.$domain" | tr ' ' ' \n'  >> /home/admin/list/xz.txt





        #-----------------------稳体育------------------------------
        ###########################################################

        elif [ $choice -eq 3 ] ;then 
            echo " ======started create SLL for domain (h5 version) : m.$domain ======"  
            echo "$config_wty_m80" >> $config_wty
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d m.$domain --nginx $config_wty --debug

            if [ $? -eq 0 ]; then
                echo "$config_wty_m443" >> $config_wty
                echo "证书已经生成成功"
                nginx -s reload
           else
                echo "证书生成错误，请检查"
            fi

            #for PC
            echo " ======started create SLL for domain (PC version) : $domain ======"  
            echo "$config_wty_pc80" >> $config_wty
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_wty --debug

            if [ $? -eq 0 ]; then

                echo "$config_wty_pc443" >> $config_wty
                cat "$mb_file" >> $config_wty
                echo "$config_mobi" >> $config_wty
        #pc www
                echo "$config_wty_pcwww" >> $config_wty
                /root/.acme.sh/acme.sh --issue -d www.$domain --nginx $config_wty --debug
                echo "$config_wty_pcmb" >> $config_wty
                cat "$mb_file" >> $config_wty
                echo "$config_mobi" >> $config_wty
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi


            #for update
            echo " ======started create SLL for domain (update version) : update.$domain ======"        
            echo "$config_wty_update80" >> $config_wty
            nginx -s reload


            /root/.acme.sh/acme.sh --issue -d update.$domain --nginx $config_wty --debug

            if [ $? -eq 0 ]; then
                echo "$config_wty_update443" >> $config_wty
                echo "证书已经生成成功"
                nginx -s reload
            else
                echo "证书生成错误，请检查"
            fi    

echo "m.$domain" | tr ' ' ' \n'  >> /home/admin/list/wty.txt
echo "$domain" | tr ' ' ' \n'  >> /home/admin/list/wty.txt
echo "www.$domain" | tr ' ' ' \n'  >> /home/admin/list/wty.txt
echo "update.$domain" | tr ' ' ' \n'  >> /home/admin/list/wty.txt




        
        else
	        echo "some wrong"
        fi
    



else
    echo "Dont have this project pls choice again"
fi

