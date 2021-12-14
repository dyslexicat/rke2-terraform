# Security group for control plane
resource "aws_security_group" "cluster_sg" {
  name   = "k8s-cluster-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "k8s-sg"
  }
  
 /* Egress Rules */
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  /* Self Ingress Rules */
  ingress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    self = true
  }

  ingress {
    from_port = 8472
    to_port = 8472
    protocol = "udp"
    self = true
  }

  ingress {
    from_port = 9099
    to_port = 9099
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 9443
    to_port = 9443
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 10250
    to_port = 10250
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 10254
    to_port = 10254
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 2376
    to_port = 2376
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 2379
    to_port = 2379
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 2380
    to_port = 2380
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 2380
    to_port = 2380
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 179
    to_port = 179
    protocol = "tcp"
    self = true
  }

  /* Public Ingress Rules */
  ingress {
    from_port = 30000
    to_port = 32767
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8443
    to_port = 8443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9345
    to_port = 9345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
