

locals {
  tags = {
    Project     = var.project
    createdby   = var.createdby
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "aws_lb" {
  source                     = "../zookeeper-module-nlb"
  name                       = var.project
  internal                   = var.lb_internal
  load_balancer_type         = var.load_balancer_type
  subnets                    = var.lb_subnets
  enable_deletion_protection = var.lb_enable_deletion_protection

  lb_target_port = var.lb_target_port
  lb_protocol    = var.lb_protocol
  lb_target_type = var.lb_target_type
  vpc_id         = var.vpc_id

  lb_listener_port     = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol

  tags = local.tags
}

