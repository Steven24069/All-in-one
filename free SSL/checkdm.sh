#!/bin/bash

domain_pc="/home/admin/dm_pc.txt"
domain_h5="/home/admin/dm_h5.txt"
domain_update="/home/admin/dm_update.txt"



config_pc="/etc/nginx/conf.d/wqnew-pc.conf"
config_h5="/etc/nginx/conf.d/wqnew-h5.conf"
config_update="/etc/nginx/conf.d/wqnew-update.conf"

timetd=$(date "+%Y%m%d")
echo $timetd

log_file="/home/admin/logdm.txt"

while read -r domain; do
    status_code=$(curl --head -k --silent --output /dev/null --write-out "%{http_code}" --insecure  https://"$domain")
    
    if [ "$status_code" -ge 200 ] && [ "$status_code" -le 302 ]; then
        echo "Domain $domain is using HTTPS."
    else
        echo "$timetd Domain $domain is not using HTTPS. =>>>>>>>>>>>>>>>>>>>>>>> check" >>  "$log_file"
       # /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_h5 --debug --force
    fi
done < "$domain_h5"

cat  $log_file
