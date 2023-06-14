#! /bin/bash
dbtime=$(date "+%Y%m%d")
echo $dbtime


cd /Users/steven/Desktop/beifen/shujuk
mkdir $dbtime

cd /Users/steven/Desktop/beifen/shujuk/$dbtime

tongji='log_'$dbtime'.sql'
echo $tongji

freelan='im_'$dbtime'.sql'
echo $freelan

server='game_live_'$dbtime'.sql'
echo $server
scp root@43.198.46.158:/home/db/\{$tongji,$freelan,$server\} /Users/steven/Desktop/beifen/shujuk/$dbtime


cd /Users/steven/Desktop/beifen/shujuk
zip -r $dbtime.zip $dbtime

rm -rf $dbtime
ls

