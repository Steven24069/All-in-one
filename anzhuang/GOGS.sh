
#安装GIT
yum install -y git




#安装MYSQL
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

sudo yum  localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

sudo yum install -y mysql-community-server 

# vagrant
#systemctl start firewalld
#firewall-cmd --zone=public --add-port=3306/tcp --permanent
#firewall-cmd --zone=public --add-port=3000/tcp --permanent
#systemctl restart firewalld

systemctl  start mysqld
systemctl status mysqld

#拿mysql密码 ------------
#grep 'A temporary password' /var/log/mysqld.log |tail -1

#mysql -u root -p 
#kvb<HpjX7dS
#:90>pglAPe6b
#ALTER USER 'root'@'localhost' IDENTIFIED BY 'kvb<HpjX7dS';
#create database gogs default charset utf8 collate utf8_general_ci;



#安装Wget
yum install -y wget

#安装GOGS

yum install -y golang
mkdir -p /opt/gogs
cd /opt/gogs


wget https://dl.gogs.io/0.11.86/gogs_0.11.86_linux_amd64.tar.gz
tar -xzvf gogs_0.11.86_linux_amd64.tar.gz
useradd git
chown -R git:git /opt/gogs/gogs




cat <<EOF >  /etc/systemd/system/gogs.service
[Unit]
Description=Gogs
After=syslog.target
After=network.target

[Service]
User=git
Group=git
ExecStart=/opt/gogs/gogs/gogs web
Restart=always

[Install]
WantedBy=multi-user.target
EOF


#Start server

systemctl daemon-reload
systemctl start gogs
systemctl status gogs

#webhook url set from gogs
#http://jenkins.jkvesds.com:9099/gogs-webhook/?job=Test


















