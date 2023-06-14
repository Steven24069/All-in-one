cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/f7* /Users/steven/Desktop/command/COSCMD/f7


cd /Users/steven/Desktop/command/COSCMD/f7
unzip  f7*
ls | grep "^f7"

folder_count=$(find /Users/steven/Desktop/command/COSCMD/f7/dist -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "
echo " 0%   of $folder_count  "


coscmd -c /Users/steven/Desktop/command/COSCMD/f7/f7_conf  -l /Users/steven/Desktop/command/COSCMD/f7/f7_log upload -r /Users/steven/Desktop/command/COSCMD/f7/dist/ /h5

echo "finish upload $(ls | grep "^f7")"

file_count=$( cat f7_log | tail -1 | cut -d ' ' -f6)
echo " 已经上传 ：$file_count 文件 "

percentage=$(( $file_count * 100 / $folder_count )) 
echo " 已上传 ： $percentage% ($file_count      of   $folder_count) "

echo -n > f7_log



#upload new file index.html to server and reload nginx 
#:<<'END'
server="101.32.176.101"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/f7tvfrlan/index.html /home/www/f7tvfrlan/index.html-$today  && ls /home/www/f7tvfrlan "
scp /Users/steven/Desktop/COSCMD/f7/dist/index.html "$username@$server:/home/www/f7tvfrlan"
ssh "$username@$server"  ls "/home/www/f7tvfrlan"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
#END

rm -rf dist
rm -rf f7*