#!/bin/bash

exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data script at $(date)"

# Sleep for a while to ensure that the instance is fully initialized
sleep 60

# Install and start Nginx
sudo yum update -y
sudo yum install -y nginx
sudo service nginx start
sudo chkconfig nginx on

echo "User data script completed at $(date)"