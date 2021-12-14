# Security group for control plane
resource "aws_security_group" "cluster_sg" {
  name   = "k8s-cluster-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "k8s-sg"
  }
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

## Ingress rule
resource "aws_security_group_rule" "sg_ingress_public" {
  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
  from_port   = 0
  to_port     = 0
  protocol          = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
