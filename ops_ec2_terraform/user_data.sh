#!/bin/bash

#Install docker

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install -y docker-ce
if [ $? -eq 0 ]
then
    sudo usermod -aG docker ubuntu
fi


#install Jenkins

apt-get update

asudo apt-get -y update

# Install OpenJDK 8
sudo apt-get -y install openjdk-8-jdk

# Install Jenkins
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y install jenkins

