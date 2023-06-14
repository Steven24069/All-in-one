cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/hot* /Users/steven/Desktop/COSCMD/rsb


cd /Users/steven/Desktop/COSCMD/rsb
unzip  hot*
ls | grep "^hot" 

mv dist h5

ossutil cp -r /Users/steven/Desktop/COSCMD/rsb/h5 oss://resaiba/h5/ --config-file /Users/steven/Desktop/COSCMD/rsb/rsboss_conf

echo "finish upload $(ls | grep "^hot")"
rm -rf h5
rm -rf hot*