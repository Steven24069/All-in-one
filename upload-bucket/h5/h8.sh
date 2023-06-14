cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/r8* /Users/steven/Desktop/command/COSCMD/h8


cd /Users/steven/Desktop/command/COSCMD/h8
unzip  r8*
ls | grep "^r8"

folder_count=$(find /Users/steven/Desktop/command/COSCMD/h8/dist -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "
echo " 0%   of $folder_count  "


coscmd -c /Users/steven/Desktop/command/COSCMD/h8/h8_conf  -l /Users/steven/Desktop/command/COSCMD/h8/h8_log upload -r /Users/steven/Desktop/command/COSCMD/h8/dist/ /h5

echo "finish upload $(ls | grep "^r8")"

file_count=$( cat h8_log | tail -1 | cut -d ' ' -f6)
echo " 已经上传 ：$file_count 文件 "

percentage=$(( $file_count * 100 / $folder_count )) 
echo " 已上传 ： $percentage% ($file_count      of   $folder_count) "

echo -n > h8_log



#upload new file index.html to server and reload nginx 
#:<<'END'
server="43.135.79.144"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/h8tv/index.html /home/www/h8tv/index.html-$today  && ls /home/www/h8tv "
scp /Users/steven/Desktop/COSCMD/h8/dist/index.html "$username@$server:/home/www/h8tv"
ssh "$username@$server"  ls "/home/www/h8tv"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
#END

rm -rf dist
rm -rf r8*