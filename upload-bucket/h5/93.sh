cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/93_5* /Users/steven/Desktop/command/COSCMD/93


cd /Users/steven/Desktop/command/COSCMD/93
unzip  93_5*
ls | grep "^93_5"

folder_count=$(find /Users/steven/Desktop/command/COSCMD/93/dist -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "
echo " 0%   of $folder_count  "


coscmd -c /Users/steven/Desktop/command/COSCMD/93/93_conf  -l /Users/steven/Desktop/command/COSCMD/93/93_log upload -r /Users/steven/Desktop/command/COSCMD/93/dist/ /h5

echo "finish upload $(ls | grep "^93_5")"

file_count=$( cat 93_log | tail -1 | cut -d ' ' -f6)
echo " 已经上传 ：$file_count 文件 "

percentage=$(( $file_count * 100 / $folder_count )) 
echo " 已上传 ： $percentage% ($file_count      of   $folder_count) "

echo -n > 93_log



#upload new file index.html to server and reload nginx 
#:<<'END'
server="43.128.43.6"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/93tv/index.html /home/www/93tv/index.html-$today  && ls /home/www/93tv "
scp /Users/steven/Desktop/COSCMD/93/dist/index.html "$username@$server:/home/www/93tv"
ssh "$username@$server"  ls "/home/www/93tv"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
#END

rm -rf dist
rm -rf 93_5*