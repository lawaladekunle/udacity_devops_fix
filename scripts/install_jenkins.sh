#!/usr/bin/env bash

# -------------------------------Pre-requiste-----------------------------------
# sudo su -i (Make sure to login as root)
# clone repo https://github.com/adeelbarki/capstone-clouddevops-docker-jenkins-aws-eks.git
# change permission on file in script folder
# sudo chown ubuntu:ubuntu <filename> (optional)
# chmod +x install_jenkins.sh

# ---------------------------------Install Jenkins---------------------------------
apt -y update
apt -y upgrade
apt -y install default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt -y update
apt -y install jenkins

# -----------------------------Jenkins Status check-------------------------------
# Check Jenkins status
# systemctl status jenkins

# ---------------------------------Install Tidy------------------------------------
apt-get -y install tidy

# -----------------------Find Autogenerated Password for Jenkins-------------------
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Finally visit the dns or ip address with port 8080 on your browser to launch Jenkins
