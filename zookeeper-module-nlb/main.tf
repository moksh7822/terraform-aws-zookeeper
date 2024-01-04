resource "aws_lb" "nlb" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = "network"
  #security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_target_group" "target_group" {
  name                 = "tg-${var.name}"
  port                 = var.lb_target_port
  protocol             = var.lb_protocol
  target_type          = var.lb_target_type
  vpc_id               = var.vpc_id
  tags        = merge({ "Name" = "tg-${var.name}" }, var.tags)
  depends_on  = [aws_lb.nlb]
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.lb_listener_port     #"443"
  protocol          = var.lb_listener_protocol #"TLS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
