cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/btv6* /Users/steven/Desktop/COSCMD/btv


cd /Users/steven/Desktop/COSCMD/btv

unzip  btv6*
ls | grep "^btv6" 

mv dist h5

coscmd -c /Users/steven/Desktop/COSCMD/btv/btv_conf  -l /Users/steven/Desktop/COSCMD/93/btv_log upload -rs /Users/steven/Desktop/COSCMD/btv/h5/ /

echo "finish upload $(ls | grep "^btv6")"
rm -rf h5
rm -rf btv6*