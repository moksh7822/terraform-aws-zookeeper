
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
