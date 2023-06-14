cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/93_5* /Users/steven/Desktop/COSCMD/93


cd /Users/steven/Desktop/COSCMD/93
unzip  93_5*
ls | grep "^93_5" 

mv dist h5

coscmd -c /Users/steven/Desktop/COSCMD/93/config1_conf  -l /Users/steven/Desktop/COSCMD/93/cos_log upload -rs /Users/steven/Desktop/COSCMD/93/h5/ /h5

echo "finish upload $(ls | grep "^93_5")"
rm -rf h5
rm -rf 93_5*