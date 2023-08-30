#!/bin/bash

# Đường dẫn đến thư mục A
folder_A="/etc/nginx/conf.d/"

# Lấy danh sách các file trong thư mục A và lưu vào một mảng
file_list=()
index=1
for file in "$folder_A"/*; do
    if [ -f "$file" ]; then
        file_list+=("$file")
        echo "$index. $(basename "$file")"
        ((index++))
    fi
done

# Hỏi người dùng chọn số thứ tự của file
read -p "Chọn số thứ tự của file: " choice

# Kiểm tra xem số thứ tự có hợp lệ hay không
if [ "$choice" -ge 1 ] && [ "$choice" -le "${#file_list[@]}" ]; then
    selected_file="${file_list[$((choice-1))]}"
    echo "Bạn đã chọn file: $(basename "$selected_file")"
    cat $selected_file
    # Thêm các lệnh xử lý file ở đây (nếu cần)
else
    echo "Số thứ tự không hợp lệ. Vui lòng chọn lại."
fi

