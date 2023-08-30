sudo yum install -y wget


sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo


sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key

sudo yum -y upgrade
# Add required dependencies for the jenkins package
yum install -y java-11-openjdk
yum install -y jenkins



#systemctl start firewalld
#firewall-cmd --zone=public --add-port=8080/tcp --permanent

#firewall-cmd --permanent --add-service=http
#systemctl  reload firewalld


systemctl start jenkins
systemctl enable jenkins
systemctl status jenkins

sudo sed -i 's/Environment="JENKINS_PORT=8080"/Environment="JENKINS_PORT=9099"/' /usr/lib/systemd/system/jenkins.service
systemctl daemon-reload

systemctl restart jenkins

#--------------------------
#vim /usr/lib/systemd/system/jenkins.service
#setup port
#or /etc/sysconfig/jenkins
#systemctl daemon-reload
#systemctl restart jenkins

#read problem : https://zhuanlan.zhihu.com/p/609882788



#systemctl list-units

:<<'END'
upstream jenkins{
        server 18.162.236.14:9099;
        }
server {
        listen 80;
        server_name jenkins.frljksfess.com;
  root            /var/lib/jenkins/%C/jenkins/war/;

  access_log      /var/log/nginx/jenkins.access.log;
  error_log       /var/log/nginx/jenkins.error.log;     

  location / {
      sendfile off;
      proxy_pass         http://jenkins ;
      proxy_redirect     default;
      proxy_http_version 1.1;

      # Required for Jenkins websocket agents
#      proxy_set_header   Connection        $connection_upgrade;
#      proxy_set_header   Upgrade           $http_upgrade;

      proxy_set_header   Host              $http_host;
      proxy_set_header   X-Real-IP         $remote_addr;
      proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
      proxy_set_header   X-Forwarded-Proto $scheme;
      proxy_max_temp_file_size 0;

      #this is the maximum upload size
      client_max_body_size       10m;
      client_body_buffer_size    128k;

      proxy_connect_timeout      90;
      proxy_send_timeout         90;
      proxy_read_timeout         90;
      proxy_buffering            off;
      proxy_request_buffering    off; # Required for HTTP CLI commands
      proxy_set_header Connection ""; # Clear for keepalive

        }
}
END


