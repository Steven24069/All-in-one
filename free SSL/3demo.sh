#!/bin/bash 

# path to folder A
folder_A="/etc/nginx/conf.d/"

mb_file="/home/mobi.txt"


ssl_file=$domain"_ecc"

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
    echo "The file you choice is : $(basename "$selected_file")"
    cat $selected_file

    #更改config file
    echo "pls put the domain here u wanna add to $config"
    read -p "add domain : " domain



ssl_file=$domain"_ecc"

	# H5
config_m80="
    server{
        listen 80;
        server_name $domain;
        root /home/www/newkw;
        index index.html index.htm;
    }
    "

config_m443="
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
        server_name $domain;
        root /home/www/wqtvupdate;
        index index.html index.htm;
    }
    "

config_update443="
    server{
    listen       443 ssl;
    server_name  $domain;
    ssl_certificate      /root/.acme.sh/$ssl_file/$domain.cer;
    ssl_certificate_key  /root/.acme.sh/$ssl_file/$domain.key;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   /home/www/wqtvupdate;
        index  index.html index.htm;
    }
    }
"

    if [ $choice == 5 ] ;then

        echo "$config_m80" >> $selected_file

        echo $config_content
        nginx -s reload


        /root/.acme.sh/acme.sh --issue -d $domain --nginx $selected_file --debug

        if [ $? -eq 0 ]; then
            echo "$config_m443" >> $selected_file
            echo "证书已经生成成功"
            nginx -s reload
        else
            echo "证书生成错误，请检查"
        fi

    elif [[ $choice == 6 ]]; then
        echo "$config_pc80" >> $selected_file

        echo $config_content
        nginx -s reload


        /root/.acme.sh/acme.sh --issue -d $domain --nginx $selected_file --debug

        if [ $? -eq 0 ]; then
		#
            echo "$config_pc443" >> $selected_file
	    
	    cat "$mb_file" >> $selected_file
	    echo "$config_mobi" >> $selected_file
		#pc www
	    echo "$config_pcwww" >> $selected_file
            /root/.acme.sh/acme.sh --issue -d www.$domain --nginx $selected_file --debug
	    echo "$config_pcmb" >> $selected_file
	    cat "$mb_file" >> $selected_file
	    echo "$config_mobi" >> $selected_file
            echo "证书已经生成成功"
            nginx -s reload
        else
            echo "证书生成错误，请检查"
        fi
        #statements
    elif [[ $choice == 7 ]]; then
         #statements [[ ]]
         echo "$config_update80" >> $selected_file

        echo $config_content
        nginx -s reload


        /root/.acme.sh/acme.sh --issue -d $domain --nginx $selected_file --debug

        if [ $? -eq 0 ]; then
            echo "$config_update443" >> $selected_file
            echo "证书已经生成成功"
            nginx -s reload
        else
            echo "证书生成错误，请检查"
        fi

    else
        echo "请再确认添加文件"
    fi

    # add more your command here
else
    echo "This file not exists,pls choice again"
fi
