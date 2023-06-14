sudo yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-9.5.2-1.x86_64.rpm

#start grafana server
systemctl start grafana-server
systemctl enable grafana-server
systemctl status grafana-server