cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/wq8* /Users/steven/Desktop/command/COSCMD/wqtv


cd /Users/steven/Desktop/command/COSCMD/wqtv
unzip  wq8*
ls | grep "^wq8"

#folder_count=$(find /Users/steven/Desktop/command/COSCMD/wqtv/dist -type f |wc -l )
#echo " 解压后总共有 ：$folder_count file "

#echo " Now start to upload file to object storage "
#echo " 0%   of $folder_count  "


cossutil cp -r /Users/steven/Desktop/command/COSCMD/wqtv/dist/ oss://ossutil-demo22/h5/ --config-file /Users/steven/Desktop/command/OSSUTIL/oss.conf

echo "finish upload $(ls | grep "^wq8")"
:<<'END'
file_count=$( cat wqtv_log | tail -1 | cut -d ' ' -f6)
echo " 已经上传 ：$file_count 文件 "

percentage=$(( $file_count * 100 / $folder_count )) 
echo " 已上传 ： $percentage% ($file_count      of   $folder_count) "

echo -n > wqtv_log



#upload new file index.html to server and reload nginx 
:<<'END'
server="43.135.16.143"                 #服务器IP
username="root"                         #用户登录
reload_nginx="sudo nginx -s reload"     #重启Nginx
today=$(date "+%Y%m%d-%H%M%S-bk")       
echo $today
 #备份当前的 index.html代码
ssh "$username@$server" mv "/home/www/wqtv/index.html /home/www/wqtv/index.html-$today  && ls /home/www/wqtv "
scp /Users/steven/Desktop/COSCMD/wqtv/dist/index.html "$username@$server:/home/www/wqtv"
ssh "$username@$server"  ls "/home/www/wqtv"
ssh "$username@$server" "$reload_nginx"
echo "finish reload nginx"
END

rm -rf dist
rm -rf wq8*