#!/bin/bash

# Đọc tập tin chứa danh sách các domain
filename="ping_domain.txt"

while IFS= read -r domain; do
    # Sử dụng lệnh ping để lấy địa chỉ IP của domain
    ip_address=$(ping -c 1 "$domain" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -1)

    # In ra màn hình kết quả
    echo "Domain: $domain - IP Address: $ip_address"

    # Hoặc lưu vào một tập tin khác nếu cần
    # echo "Domain: $domain - IP Address: $ip_address" >> output_file.txt
done < "$filename"
