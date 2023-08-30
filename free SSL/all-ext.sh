#!/bin/bash 

domain_pc="/home/admin/dm_pc.txt"
domain_h5="/home/admin/dm_h5.txt"
domain_update="/home/admin/dm_update.txt"



config_pc="/etc/nginx/conf.d/wqnew-pc.conf"
config_h5="/etc/nginx/conf.d/wqnew-h5.conf"
config_update="/etc/nginx/conf.d/wqnew-update.conf"



while IFS= read -r domain; do
                echo " read domain file"
                echo "========="

                /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_pc --debug --force
                echo "========"

        done < "$domain_pc"

while IFS= read -r domain; do
                echo " read domain file"
                echo "========="

                /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_h5 --debug --force
                echo "========"

        done < "$domain_h5"

while IFS= read -r domain; do
                echo " read domain file"
                echo "========="

                /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_update --debug --force
                echo "========"

        done < "$domain_update"



