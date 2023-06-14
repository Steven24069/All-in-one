cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/hot* /Users/steven/Desktop/command/COSCMD/demo


cd /Users/steven/Desktop/command/COSCMD/demo
unzip  hot*
ls | grep "^hot"

folder_count=$(find /Users/steven/Desktop/command/COSCMD/demo/dist -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "
echo " 0%   of $folder_count  "


coscmd -c /Users/steven/Desktop/command/COSCMD/demo/config1_conf  -l /Users/steven/Desktop/command/COSCMD/demo/cos_log upload -r /Users/steven/Desktop/command/COSCMD/demo/dist/ /h5

echo "finish upload $(ls | grep "^hot")"

file_count=$( cat cos_log | tail -1 | cut -d ' ' -f6)
echo " 已经上传 ：$file_count 文件 "

percentage=$(( $file_count * 100 / $folder_count )) 
echo " 已上传 ： $percentage% ($file_count      of   $folder_count) "

echo -n > cos_log



#upload new file index.html to server and reload nginx 
:<<'END'
server="47.243.140.212"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       #备份当前的 index.html代码
echo $today

ssh "$username@$server" mv "/home/www/demo/index.html /home/www/demo/index.html-$today  && ls /home/www/demo "
scp /Users/steven/Desktop/COSCMD/demo/dist/index.html "$username@$server:/home/www/demo"
ssh "$username@$server"  ls "/home/www/demo"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
END

rm -rf dist
rm -rf hot*