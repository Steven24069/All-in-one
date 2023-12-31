yum install wget -y

#Add user service prometheus
useradd --no-create-home --shell /bin/false prometheus

mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus


cd /opt
wget https://github.com/prometheus/prometheus/releases/download/v2.44.0/prometheus-2.44.0.linux-amd64.tar.gz  -O prometheus.tar.gz
tar xvf prometheus.tar.gz 
mv prometheus-2.44.0.linux-amd64 prometheus

cp prometheus/prometheus /usr/local/bin/
cp prometheus/promtool /usr/local/bin/

chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

cp -r prometheus/consoles /etc/prometheus
cp -r prometheus/console_libraries /etc/prometheus

chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries

rm -rf prometheus*
cd -

#Create prometheus server - config
cat <<EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s               
    static_configs:
      - targets: ['localhost:9090']
EOF
#scrape_interval: 5s    means is every 5 second  will be update if not set up will be normal : global is 15s

#Add systemd
cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

#Start prometheus
systemctl daemon-reload
systemctl start prometheus
systemctl status prometheus
systemctl enable prometheus
systemctl restart prometheus
