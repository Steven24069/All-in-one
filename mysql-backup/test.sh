#! /bin/bash

dbtime=20230504

cd /Users/steven/Desktop/beifen/shujuk
mkdir $dbtime

tongji='log_'$dbtime'.sql'
echo $tongji

freelan='im_'$dbtime'.sql'
echo $freelan

server='game_live_'$dbtime'.sql'
echo $server


scp root@43.198.46.158:/home/db/\{$freelan,$server,$tongji\} /Users/steven/Desktop/beifen/shujuk/$dbtime

cd /Users/steven/Desktop/beifen/shujuk
zip -r $dbtime.zip $dbtime

rm -rf $dbtime
ls
