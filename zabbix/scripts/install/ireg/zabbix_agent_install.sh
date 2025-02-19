#!/bin/bash

# Script Name: zabbix_agent2_install.sh
# Description: This script installs Zabbix Agent 2 on a Debian-based system.
# Description: This script installs Zabbix Agent 2 and its plugins on a Debian-based system.
# Date: 2025-01-29
# Version: 1.0
# Version: 1.1
# Notes: This script is intended for use on Debian-based systems only.

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please use sudo or switch to root user."
   exit 1
fi
# Function to execute a command and handle errors
execute_command() {
    local command="$1"
    local error_message="$2"

# Step 1: Download the Zabbix Release package
echo "Downloading the Zabbix Release package..."
wget $ZABBIX_RELEASE_URL -O $ZABBIX_RELEASE_DEB
if [[ $? -ne 0 ]]; then
    echo "Failed to download the Zabbix release package. Exiting..."
# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo or switch to root user."
    exit 1
fi

# Step 2: Extract and install Zabbix Release package
echo "Installing the Zabbix Release package..."
dpkg -i $ZABBIX_RELEASE_DEB
if [[ $? -ne 0 ]]; then
    echo "Failed to install the Zabbix release package. Exiting..."
    exit 1
fi

source vars.env

echo "Starting Zabbix Agent 2 installation script..."
# Step 1: Download the Zabbix Release package
echo "Downloading the Zabbix Release package..."
execute_command "wget $ZABBIX_RELEASE_URL -O $ZABBIX_RELEASE_DEB" "Failed to download the Zabbix release package. Exiting..."

# Step 2: Extract and install Zabbix Release package
execute_command "apt update" "Failed to update package list. Exiting..."
# Step 4: Install the Zabbix Agent 2
echo "Installing Zabbix Agent 2..."
apt install -y zabbix-agent2
if [[ $? -ne 0 ]]; then
    echo "Failed to install Zabbix Agent 2. Exiting..."
    exit 1
fi

execute_command "apt install -y zabbix-agent2" "Failed to install Zabbix Agent 2. Exiting..."
# Step 5: Install Zabbix Agent 2 plugins
echo "Installing Zabbix Agent 2 plugins..."
apt install -y zabbix-agent2-plugin-mongodb zabbix-agent2-plugin-mssql zabbix-agent2-plugin-postgresql
if [[ $? -ne 0 ]]; then
    echo "Failed to install Zabbix Agent 2 plugins. Exiting..."
    exit 1
fi

# Step 6: Prompt for the GitHub link to download the zabbix_agent2.conf file
echo "Please enter the GitHub URL to download the customized zabbix_agent2.conf file:"
read -p "GitHub URL: " GITHUB_URL

execute_command "apt install -y ${ZBX_AGENT_PLUGINS[@]}" "Failed to install Zabbix Agent 2 plugins. Exiting..."

# Step 6: Download the zabbix_agent2.conf file
read -p "Please enter the GitHub URL to download the customized zabbix_agent2.conf file: " GITHUB_URL
if [[ -z "$GITHUB_URL" ]]; then
    echo "No GitHub URL provided. Exiting..."
    exit 1
fi

# Download the zabbix_agent2.conf file
echo "Downloading the zabbix_agent2.conf file from $GITHUB_URL..."
wget $GITHUB_URL -O $ZABBIX_CONF_PATH
if [[ $? -ne 0 ]]; then
    echo "Failed to download the zabbix_agent2.conf file. Exiting..."
    exit 1
fi

echo "zabbix_agent2.conf file has been copied to $ZABBIX_CONF_DIR."
echo "zabbix_agent2.conf file has been copied to $ZABBIX_CONF_DIR."

execute_command "wget $GITHUB_URL -O $ZBX_AGENT_CONF_PATH" "Failed to download the zabbix_agent2.conf file. Exiting..."

echo "zabbix_agent2.conf file has been copied to $ZBX_AGENT_CONF_PATH."
# Step 7: Restart the Zabbix Agent 2 service
systemctl restart zabbix-agent2
if [[ $? -ne 0 ]]; then
    echo "Failed to restart the Zabbix Agent 2 service. Exiting..."
    exit 1
fi

echo "Restarting the Zabbix Agent 2 service..."
execute_command "systemctl restart zabbix-agent2" "Failed to restart the Zabbix Agent 2 service. Exiting..."
echo "Zabbix Agent 2 installation and configuration complete!"
# test123.txt

This is a test file created in the Install Scripts directory.
