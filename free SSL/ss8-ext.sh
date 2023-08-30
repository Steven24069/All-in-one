config_ss8="/etc/nginx/conf.d/ss8-acme.conf"
values=("赛事吧" "星足" "稳体育")

# In ra danh sách giá trị cùng với số thứ tự tương ứng
for i in "${!values[@]}"; do
    echo "$((i+1)). ${values[i]}"
done


#choice your project you want to do

read -p " Pls choice your project you want to update:  " choice

#

if [[ $choice -ge 1 && $choice -le ${#values[@]} ]]; then
    selected_value="${values[choice-1]}"
    echo "your choice is: $selected_value "
	if [ $choice -eq 1 ] ;then

		echo "now to update SSL for $choice"



		while IFS= read -r domain; do
                	echo " read domain file"
                	echo "========="

                	/root/.acme.sh/acme.sh --issue -d $domain --nginx $config_ss8 --debug --force
                	echo "========"

        	done < /home/admin/ss8.txt
 
	
	



	elif [ $choice -eq 2 ] ;then
		
                echo "now to update SSL for $choice"



                while IFS= read -r domain; do
                        echo " read domain file"
                        echo "========="

                        /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_xz --debug --force
                        echo "========"

                done < /home/admin/xz.txt


	
	elif [ $choice -eq 3 ] ;then
		echo "now to update SSL for $choice"



                while IFS= read -r domain; do
                        echo " read domain file"
                        echo "========="

                        /root/.acme.sh/acme.sh --issue -d $domain --nginx $config_wty --debug --force
                        echo "========"

                done < /home/admin/wty.txt
 

	else 
		echo"something wrong , pls choice again"
	fi
else
	echo "Dont have this project pls choice again"
fi
