
yum install -y epel-release

yum install -y vim

yum install  -y postfix
systemctl enable postfix
systemctl start postfix


curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash


yum install -y gitlab-ce


#设置端口8000
echo "nginx['listen_port']=8000" >> /etc/gitlab/gitlab.rb

gitlab-ctl reconfigure

gitlab-ctl start


:<<'END'
---------------------------------------

cat /etc/gitlab/initial_root_password 
root
z+VKelrEyx/9pXGxdXuBhuxXshpQnySAwKt19dknkQY=


server {
    listen 80;
    server_name git.demolives.vip;

    location / {
        proxy_pass http://13.213.103.168:8929;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

#change port
vim /etc/gitlab/gitlab.rb
	nginx['listen_port']=8000

gitlab-ctl reconfigure

vim /var/opt/gitlab/nginx/conf/gitlab-http.conf 
   listen *:8000;
gitlab-ctl restart
END