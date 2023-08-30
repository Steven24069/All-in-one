curl https://get.acme.sh | sh
source ~/.bashrc
acme.sh


acme.sh --register-account -m steven2406999@gmail.com



#如果nginx -s reload 报错：
#nginx -c /etc/nginx/nginx.conf


#acme.sh --issue -d wqtv7.com --nginx /etc/nginx/conf.d/demo.conf --debug

#延期
#acme.sh --issue -d wqtv7.com --nginx /etc/nginx/conf.d/demo.conf --debug --force