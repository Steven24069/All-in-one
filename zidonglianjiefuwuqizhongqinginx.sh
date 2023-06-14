#! /bin/bash/
server="47.243.140.212"

username="root"

reload_nginx="sudo nginx -s reload"

today=$(date "+%Y%m%d-%H%M%S")
echo $today
ssh "$username@$server" mv "/home/www/demo/index.html /home/www/demo/index.html-$today  && ls /home/www/demo "

scp /Users/steven/Desktop/learn/abc/index.html "$username@$server:/home/www/demo"

ssh "$username@$server"  ls "/home/www/demo"

ssh "$username@$server" "$reload_nginx"

echo "finish"