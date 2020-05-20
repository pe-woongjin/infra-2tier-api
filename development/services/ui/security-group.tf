resource "aws_security_group" "ui-sg" {
  name    = "${local.resrc_prefix_nm}-ui-sg"
  vpc_id  = var.vpc_id

  ingress {
    from_port     = 22
    to_port       = 22
    protocol      = "TCP"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  ingress {
    from_port     = 80
    to_port       = 80
    protocol      = "TCP"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  lifecycle { create_before_destroy = true }

  tags = {
    Name          = "${local.resrc_prefix_nm}-ui-sg"
    Environment   = var.environment
  }
}