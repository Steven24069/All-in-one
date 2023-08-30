#!/bin/bash

#所有项目


# Create Variables


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
    
    #赛事吧
    if [ $choice -eq 1 ] ;then
	echo "pls put the domain here u wanna add to $selected_value"
	read -p "add domain : " domain





    else
	echo "some wrong"
    fi
    



else
    echo "Dont have this project pls choice again"
fi
