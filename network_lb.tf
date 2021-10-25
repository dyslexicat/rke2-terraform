resource "aws_lb" "rke2-lb" {
  name               = "rke2-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.subnet.id]

  tags = {
    type = "rke2"
  }
}

resource "aws_lb_target_group_attachment" "master-6443" {
  target_group_arn = aws_lb_target_group.rke2-target-group-6443.arn
  target_id        = aws_spot_instance_request.master_node.spot_instance_id
  port             = 6443
}

resource "aws_lb_target_group_attachment" "master-9345" {
  target_group_arn = aws_lb_target_group.rke2-target-group-9345.arn
  target_id        = aws_spot_instance_request.master_node.spot_instance_id
  port             = 9345
}

resource "aws_lb_target_group_attachment" "slave-6443" {
  target_group_arn = aws_lb_target_group.rke2-target-group-6443.arn
  target_id        = aws_spot_instance_request.additional_master_nodes[0].spot_instance_id
  port             = 6443
}

resource "aws_lb_target_group_attachment" "slave-9345" {
  target_group_arn = aws_lb_target_group.rke2-target-group-9345.arn
  target_id        = aws_spot_instance_request.additional_master_nodes[0].spot_instance_id
  port             = 9345
}

resource "aws_lb_target_group_attachment" "slave-1-6443" {
  target_group_arn = aws_lb_target_group.rke2-target-group-6443.arn
  target_id        = aws_spot_instance_request.additional_master_nodes[1].spot_instance_id
  port             = 6443
}

resource "aws_lb_target_group_attachment" "slave-1-9345" {
  target_group_arn = aws_lb_target_group.rke2-target-group-9345.arn
  target_id        = aws_spot_instance_request.additional_master_nodes[1].spot_instance_id
  port             = 9345
}

resource "aws_lb_target_group" "rke2-target-group-6443" {
  name     = "rke2-target-group-6443"
  port     = 6443
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "rke2-target-group-9345" {
  name     = "rke2-target-group-9345"
  port     = 9345
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "rke2-lb-listener-6443" {
  load_balancer_arn = aws_lb.rke2-lb.arn
  port              = "6443"
  protocol          = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.rke2-target-group-6443.arn
  }
}

resource "aws_lb_listener" "rke2-lb-listener-9345" {
  load_balancer_arn = aws_lb.rke2-lb.arn
  port              = "9345"
  protocol          = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.rke2-target-group-9345.arn
  }
}