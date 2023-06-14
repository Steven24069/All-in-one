cp -r /Users/steven/Desktop/BIG-svn/JKsource/workspace/Android-live/93_5* /Users/steven/Desktop/command/OSSUTIL/93


cd /Users/steven/Desktop/command/OSSUTIL/93
unzip  93_5*
ls | grep "^93_5" 

file_upload="/Users/steven/Desktop/command/OSSUTIL/93/dist"

config_file="/Users/steven/Desktop/command/OSSUTIL/oss_conf"

log_file="Users/steven/Desktop/command/OSSUTIL/log.txt"


folder_count=$(find $file_upload -type f |wc -l )
echo " 解压后总共有 ：$folder_count file "

echo " Now start to upload file to object storage "


ossutil cp -r $file_upload oss://ossutil-demo22/h5/ --config-file $config_file  --force #--output-dir="$log_file" #--maxupspeed 

if [ $? -eq 0 ] ; then
		echo " upload done "
else
		echo " upload not ok "
fi

echo "finish upload $(ls | grep "^93_5")"
rm -rf dist
mv  93_5* /Users/steven/Desktop/command/OSSUTIL/93/backup

