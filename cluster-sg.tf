# Security group for control plane
resource "aws_security_group" "cluster_sg" {
  name   = "k8s-cluster-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "k8s-cluster-sg"
  }
}

# Public SG if we were separating the subnets
resource "aws_security_group_rule" "sg_ingress_public_22" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

## Egress rule
resource "aws_security_group_rule" "sg_egress_public" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Security group traffic rules
## Ingress rule
resource "aws_security_group_rule" "control_plane_inbound" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol          = "tcp"
  cidr_blocks = [var.subnet_cidr_block]
}

resource "aws_security_group_rule" "control_plane_inbound_ssh" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
  from_port   = 0
  to_port     = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "control_plane_inbound_443" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "control_plane_inbound_80" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.cluster_sg.id
}
