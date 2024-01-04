#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y

#Install Java
sudo apt install openjdk-17-jdk openjdk-17-jre -y
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' | sudo tee -a /etc/profile
echo 'PATH=$PATH:$JAVA_HOME/bin' | sudo tee -a /etc/profile
source /etc/profile

cd /home/ubuntu && wget http://archive.apache.org/dist/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz
cd /home/ubuntu && tar -xvzf apache-zookeeper-3.8.0-bin.tar.gz
cp -R /home/ubuntu/apache-zookeeper-3.8.0-bin /home/ubuntu/zookeeper
cd /home/ubuntu/zookeeper/conf && touch zoo.cfg
chown -R ubuntu: /home/ubuntu/*

cat <<EOT >> /home/ubuntu/zookeeper/conf/zoo.cfg
dataDir=/var/lib/zookeeper
clientPort=2181
initLimit=5
syncLimit=2
server.1=<zookeeper-hostname>:2888:3888
server.2=<zookeeper-hostname>:2888:3888
server.3=<zookeeper-hostname>:2888:3888
EOT

sudo mkdir /var/lib/zookeeper
sudo touch /var/lib/zookeeper/myid
sudo sh -c "echo 'zk-id' > /var/lib/zookeeper/myid"
sudo /home/ubuntu/zookeeper/bin/zkServer.sh restart
