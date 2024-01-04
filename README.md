## terraform-aws-zookeeper

This repository collects zookeeper autoscaling and NLB modules with the steps to provision a three node zookeeper cluster in AWS.


### Prerequisites

* An AWS account and IAM user with required privileges.

* VPC and three private subnets.

* Terraform installed on your machine.

### Getting started

Have a look at ec2-int.sh and terraform.tfvars and modify it according to your requirement.

```
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
```

```

# Common
project   = ""
createdby = "terraform"

# General 
aws_region = "us-east-1"


# LB is creating only 1 ENI. it should be number of subnet provided

# Load Balancer
lb_name                       = ""
lb_internal                   = true
load_balancer_type            = "network"
lb_subnets                    = ["subnet-abc", "subnet-def", "subnet-xyz"]
lb_enable_deletion_protection = false
lb_target_port                = 2181
lb_protocol                   = "TCP"
lb_target_type                = "instance" # While using LB with ASG (Auto Scaling Group , the type must be 'instance' not ip)
vpc_id                        = ""
lb_listener_port              = 2181
lb_listener_protocol          = "TCP"


# Launch Template

image_id               = ""
instance_type          = ""
key_name               = ""
vpc_security_group_ids = [""]
iam_role               = [""]


# Auto Scaling
max_size              = 2
min_size              = 2
desired_capacity      = 2
asg_health_check_type = "ELB"
target_group_arns     = []
```


  
