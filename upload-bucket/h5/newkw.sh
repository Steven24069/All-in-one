cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/kw_19* /Users/steven/Desktop/command/COSCMD/newkuwan


cd /Users/steven/Desktop/command/COSCMD/newkuwan
unzip  kw_19*
ls | grep "^kw_19" 

file_upload="/Users/steven/Desktop/command/COSCMD/newkuwan/dist"

config_file="/Users/steven/Desktop/command/COSCMD/newkuwan/newkwoss_conf"

#log_file="Users/steven/Desktop/command/OSSUTIL/log.txt"


folder_count=$(find $file_upload -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "


ossutil cp -r $file_upload oss://new-kw-gj/h5/ --config-file $config_file  --force #--output-dir="$log_file" #--maxupspeed 

if [ $? -eq 0 ] ; then
        echo " upload done "
else
        echo " upload not ok "
fi



#upload new file index.html to server and reload nginx 
#:<<'END'
server="8.217.95.10"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/newkw/index.html /home/www/newkw/index.html-$today  && ls /home/www/newkw "
scp /Users/steven/Desktop/command/COSCMD/newkuwan/dist/index.html "$username@$server:/home/www/newkw"
ssh "$username@$server"  ls "/home/www/newkw"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
#END

echo "finish upload $(ls | grep "^kw_19")"
rm -rf dist
mv  kw_19* /Users/steven/Desktop/command/COSCMD/newkuwan/backup
