#!/usr/bin/env bash

# Run this on a fresh Ubuntu EC2 instance.
# Recommended: t3.medium or larger
#
# Upload:
# scp -i mykey.pem setup-jenkins-ec2.sh ubuntu@<EC2_IP>:~
#
# Connect:
# ssh -i mykey.pem ubuntu@<EC2_IP>
#
# Run:
# chmod +x setup-jenkins-ec2.sh
# ./setup-jenkins-ec2.sh

set -euo pipefail

echo ">>> Updating system packages"
sudo apt-get update -y
sudo apt-get upgrade -y


# ============================================================
# INSTALL JAVA 21
# ============================================================

echo ">>> Installing Java 21"

sudo apt-get install -y \
  fontconfig \
  openjdk-21-jre

java -version


# ============================================================
# INSTALL JENKINS
# ============================================================

echo ">>> Installing Jenkins"

sudo mkdir -p /etc/apt/keyrings

# Remove any old Jenkins key if it exists
sudo rm -f /etc/apt/keyrings/jenkins-keyring.asc
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc

# Install the CURRENT Jenkins 2026 repository signing key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins LTS repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y

sudo apt-get install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo ""
echo "=================================================================="
echo " Jenkins installation completed successfully!"
echo "=================================================================="

echo ""
echo "Jenkins Status:"
sudo systemctl status jenkins --no-pager

echo ""
echo "Jenkins Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo ""
echo "Open Jenkins in your browser:"
echo "http://<EC2-PUBLIC-IP>:8080"

echo ""
echo "Make sure your EC2 Security Group allows:"
echo "TCP 8080 from your IP address"
echo "=================================================================="
