
#!/bin/bash 

domain_list="/home/dm_list.txt"
# path to folder A
folder_A="/etc/nginx/conf.d/"

#get path list
file_list=()
index=1
for file in "$folder_A"/*; do
    if [ -f "$file" ]; then
        file_list+=("$file")
        echo "$index. $(basename "$file")"
        ((index++))
    fi
done

# Ask when choice file number
read -p "Pls choice your file: " choice

# Check file if that work
if [ "$choice" -ge 1 ] && [ "$choice" -le "${#file_list[@]}" ]; then
    selected_file="${file_list[$((choice-1))]}"
    echo "Bạn đã chọn file: $(basename "$selected_file")"
    cat $selected_file
    
#check file domain_list
	while IFS= read -r domain;do
		echo " read domain file"
		echo "========="

		/root/.acme.sh/acme.sh --issue -d $domain --nginx $selected_file --debug --force
		echo "========"

	done < "$domain_list"



else
	 echo "This file not exists,pls choice again"
fi

