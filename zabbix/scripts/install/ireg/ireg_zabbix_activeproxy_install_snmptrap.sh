#!/bin/bash

 # Variables for Zabbix Proxy Configuration
SERVER="st-zabbix.stacktech.cloud"
DB_HOST=""
DB_NAME="/tmp/zabbix_proxy"
DB_USER="zabbix"
DB_PASSWORD=""
LOG_FILE="/var/log/zabbix/zabbix_proxy.log"

 # Prompt for other values if necessary
read  -p "Enter database host (leave blank for default): " DB_HOST
read  -p "Enter database password: " DB_PASSWORD

 # Create zabbix_proxy.conf dynamically
cat <<EOF > /etc/zabbix/zabbix_proxy.conf
Server=${SERVER}
DBHost=${DB_HOST}
DBName=${DB_NAME}
DBUser=${DB_USER}
DBPassword=${<PASSWORD>}
LogFile=${LOG_FILE}
LogFileSize=0
PidFile=/run/zabbix/zabbix_proxy.pid
SocketDir=/run/zabbix
StartSNMPTrapper=1
SNMPTrapperFile=/var/log/snmptrap/snmptrap.log
EOF

 # Additional installation steps if required