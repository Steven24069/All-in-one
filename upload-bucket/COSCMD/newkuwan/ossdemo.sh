cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/93_5* /Users/steven/Desktop/OSSUTIL/93


cd /Users/steven/Desktop/OSSUTIL/93
unzip  93_5*
ls | grep "^93_5" 

mv dist h5

ossutil cp -r /Users/steven/Desktop/OSSUTIL/93/h5 oss://ossutil-demo22/test-demo/h5/ --config-file /Users/steven/Desktop/OSSUTIL/oss_conf

echo "finish upload $(ls | grep "^93_5")"
rm -rf h5
rm -rf 93_5*