#!/bin/bash 

# path to folder A
folder_A="/etc/nginx/conf.d/"

#get path list
file_list=()
index=1
for file in "$folder_A"/*; do
    if [ -f "$file" ]; then
        file_list+=("$file")
        echo "$index. $(basename "$file")"
        ((index++))
    fi
done

# Ask when choice file number
read -p "Pls choice your file: " choice

# Check file if that work
if [ "$choice" -ge 1 ] && [ "$choice" -le "${#file_list[@]}" ]; then
    selected_file="${file_list[$((choice-1))]}"
    echo "Bạn đã chọn file: $(basename "$selected_file")"
    cat $selected_file

    #更改config file
    echo "pls put the domain here u wanna add to $config"
    read -p "add domain : " domain


    ssl_file=$domain"_ecc"

    config_content="
    server{
        listen 80;
        server_name $domain;
        root /home/www/newkw;
        index index.html index.htm;
    }
    "
    echo "$config_content" >> $selected_file
   
    echo $config_content
    nginx -s reload


    /root/.acme.sh/acme.sh --issue -d $domain --nginx $selected_file --debug
    
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
        echo "$config_content2" >> $selected_file
        echo "证书已经生成成功"
        nginx -s reload
    else
        echo "证书生成错误，请检查"
    fi


    # add more your command here
else
    echo "This file not exists,pls choice again"
fi



