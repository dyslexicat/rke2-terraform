output "elb_address" {
  value = aws_lb.rke2-lb.dns_name
  description = "The DNS Name of the AWS NLB"
}

output "master_public_ip_rke2" {
  value = aws_spot_instance_request.master_nodes[*].public_ip
  description = "The public IPs of the master nodes"
}

output "worker_public_ip_rke2" {
  value = aws_spot_instance_request.worker_nodes[*].public_ip
  description = "The public IPs of the worker nodes"
}
