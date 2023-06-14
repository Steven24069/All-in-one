cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/wq8* /Users/steven/Desktop/command/COSCMD/wqtv


cd /Users/steven/Desktop/command/COSCMD/wqtv
unzip  wq8*
ls | grep "^wq8" 

file_upload="/Users/steven/Desktop/command/COSCMD/wqtv/dist"

config_file="/Users/steven/Desktop/command/COSCMD/wqtv/oss_conf"

log_file="Users/steven/Desktop/command/OSSUTIL/log.txt"


folder_count=$(find $file_upload -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "


ossutil cp -r $file_upload oss://ossutil-demo22/h5/ --config-file $config_file  --force #--output-dir="$log_file" #--maxupspeed 

if [ $? -eq 0 ] ; then
        echo " upload done "
else
        echo " upload not ok "
fi



#upload new file index.html to server and reload nginx 
#:<<'END'
server="43.135.16.143"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/wqtv/index.html /home/www/wqtv/index.html-$today  && ls /home/www/wqtv "
scp /Users/steven/Desktop/command/COSCMD/wqtv/dist/index.html "$username@$server:/home/www/wqtv"
ssh "$username@$server"  ls "/home/www/wqtv"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
#END

echo "finish upload $(ls | grep "^wq8")"
rm -rf dist
mv  wq8* /Users/steven/Desktop/command/COSCMD/wqtv/backup
