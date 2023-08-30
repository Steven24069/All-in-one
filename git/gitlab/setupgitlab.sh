
yum install -y epel-release

yum install -y vim

yum install  -y postfix
systemctl enable postfix
systemctl start postfix


curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash


yum install -y gitlab-ce

echo "nginx['listen_port']=8000" >> /etc/gitlab/gitlab.rb

gitlab-ctl reconfigure

gitlab-ctl start
