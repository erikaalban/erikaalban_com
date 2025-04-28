#!/bin/bash

# Define variables
KEY_PATH="~/.ssh/my-ec2-key.pem"
EC2_USER="ec2-user"
EC2_IP="34.230.73.218"
DEST_DIR="/var/www/html/"

# SCP files to the EC2 instance
scp -i "$KEY_PATH" index.html styles.css script.js profile.jpg "$EC2_USER@$EC2_IP:$DEST_DIR"

echo "File upload complete! Your website should be live at http://$EC2_IP"


