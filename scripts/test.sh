#!/bin/bash
sudo yum install -y yum-utils 
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo docker pull sonarqube
sudo firewall-cmd --zone=public --permanent --add-port=9000/tcp
sudo firewall-cmd --reload
sudo docker run --detach -p 9000:9000 sonarqube
echo "running"