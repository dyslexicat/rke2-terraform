resource "aws_vpc" "main" {
  cidr_block           = "12.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "rke2-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rke2-gw"
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route internet gw"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "rke2-subnet"
    "kubernetes.io/cluster/my-rke2-cluster" = "owned"
  }
}

resource "aws_spot_instance_request" "master_nodes" {
  count = 3
  ami                    = var.ami_name
  spot_price             = "0.018"
  instance_type          = var.instance_type
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = var.key_name
  private_ip             = "12.0.1.1${count.index}"
  iam_instance_profile   = aws_iam_instance_profile.rancher_profile.name

  root_block_device {
      volume_type = "gp2"
      volume_size = 16
  }

  security_groups = [aws_security_group.cluster_sg.id]
  subnet_id = aws_subnet.subnet.id
}

resource "aws_ec2_tag" "master_node" {
  count = 3
  resource_id = aws_spot_instance_request.master_nodes[count.index].spot_instance_id
  key         = "Name"
  value       = "rke2-master-${count.index + 1}"
}

resource "aws_ec2_tag" "master_node_rancher" {
  count = 3
  resource_id = aws_spot_instance_request.master_nodes[count.index].spot_instance_id
  key         = "kubernetes.io/cluster/my-rke2-cluster"
  value       = "owned"
}

resource "aws_spot_instance_request" "worker_nodes" {
  count = 2
  ami                    = var.ami_name
  spot_price             = "0.018"
  instance_type          = var.instance_type
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = var.key_name
  private_ip             = "12.0.1.2${count.index}"
  iam_instance_profile   = aws_iam_instance_profile.rancher_profile.name

  root_block_device {
      volume_type = "gp2"
      volume_size = 16
  }

  security_groups = [aws_security_group.cluster_sg.id]
  subnet_id = aws_subnet.subnet.id
}

resource "aws_ec2_tag" "worker_nodes" {
  count = 2
  resource_id = aws_spot_instance_request.worker_nodes[count.index].spot_instance_id
  key         = "Name"
  value       = "rke2-worker-${count.index + 1}"
}
