output "elb_address" {
  value = aws_lb.rke2-lb.dns_name
  description = "The DNS Name of the AWS NLB"
}

output "public_ip_rke2" {
  value = aws_spot_instance_request.master_nodes[*].public_ip
  description = "The public IP of the master node"
}

