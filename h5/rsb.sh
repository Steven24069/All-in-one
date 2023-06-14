cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/hot17* /Users/steven/Desktop/command/COSCMD/rsb


cd /Users/steven/Desktop/command/COSCMD/rsb
unzip  hot17*
ls | grep "^hot17" 

file_upload="/Users/steven/Desktop/command/COSCMD/rsb/dist"

config_file="/Users/steven/Desktop/command/COSCMD/rsb/rsb_conf"

#log_file="Users/steven/Desktop/command/OSSUTIL/log.txt"


folder_count=$(find $file_upload -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "


ossutil cp -r $file_upload oss://resaiba/h5/ --config-file $config_file  --force #--output-dir="$log_file" #--maxupspeed 

if [ $? -eq 0 ] ; then
        echo " upload done "
else
        echo " upload not ok "
fi



#upload new file index.html to server and reload nginx 
#:<<'END'
server="43.129.205.237"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/rsb/index.html /home/www/rsb/index.html-$today  && ls /home/www/rsb "
scp /Users/steven/Desktop/command/COSCMD/rsb/dist/index.html "$username@$server:/home/www/rsb"
ssh "$username@$server"  ls "/home/www/rsb"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
#END

echo "finish upload $(ls | grep "^hot17")"
rm -rf dist
mv  hot17* /Users/steven/Desktop/command/COSCMD/rsb/backup
