
dbtime=$(date "+%Y%m%d")
echo $dbtime

tongji='log_'$dbtime'.sql'
echo $tongji

freelan='im_'$dbtime'.sql'
echo $freelan

server='game_live_'$dbtime'.sql'
echo $server

scp root@43.198.46.158:/home/db/\{$tongji,$freelan,$server\} /Users/steven/Desktop/beifen/shujuk

