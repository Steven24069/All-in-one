#! /bin/bash
dbtime=$(date "+%Y%m%d")
echo $dbtime


cd /Users/steven/Desktop/beifen/shujuk
mkdir $dbtime

cd /Users/steven/Desktop/beifen/shujuk/$dbtime

tongji1='log_'$dbtime'-empty.sql'
echo $tongji1

freelan1='im_'$dbtime'-empty.sql'
echo $freelan1

server1='game_live_'$dbtime'-empty.sql'
echo $server1



tongji='log_'$dbtime'.sql'
echo $tongji

freelan='im_'$dbtime'.sql'
echo $freelan

server='game_live_'$dbtime'.sql'
echo $server

scp root@43.198.46.158:/home/db/\{$tongji1,$freelan1,$server1,$freelan,$server,$tongji\} /Users/steven/Desktop/beifen/shujuk/$dbtime

cd /Users/steven/Desktop/beifen/shujuk
zip -r $dbtime.zip $dbtime

rm -rf $dbtime
ls
