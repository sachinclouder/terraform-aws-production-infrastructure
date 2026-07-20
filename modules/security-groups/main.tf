resource "aws_security_group" "alb" {

  name = "${var.project_name}-${var.environment}-alb-sg"

  description = "Application Load Balancer Security Group"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80

  to_port = 80

  ip_protocol = "tcp"

  description = "Allow HTTP"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443

  to_port = 443

  ip_protocol = "tcp"

  description = "Allow HTTPS"
}

resource "aws_vpc_security_group_egress_rule" "alb_outbound" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow outbound traffic"
}

resource "aws_security_group" "management" {
  name        = "${var.project_name}-${var.environment}-management-sg"
  description = "Security group for administrative access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-management-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "management_ssh" {
  for_each = toset(var.ssh_allowed_cidrs)

  security_group_id = aws_security_group.management.id

  description = "Allow SSH from approved CIDR"
  cidr_ipv4   = each.value
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "management_outbound" {
  security_group_id = aws_security_group.management.id

  description = "Allow outbound management traffic"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_security_group" "application" {
  name        = "${var.project_name}-${var.environment}-application-sg"
  description = "Security group for application EC2 instances"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-application-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "application_from_alb" {
  security_group_id = aws_security_group.application.id

  description                  = "Allow HTTP traffic from the ALB"
  referenced_security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "application_outbound" {
  security_group_id = aws_security_group.application.id

  description = "Allow outbound traffic from application instances"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}