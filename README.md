# Terraform RKE2
This repo provides a barebones template for creating EC2 spot instances before deploying RKE2 and Rancher.

Change the count _variables_ to the desired number of instances before running the terraform code.

## Network LB
This code creates a NLB in order to use the address as the keepalived address in a HA RKE2 installation.

## install_ansible.sh
This script is provided as an example if you want to use a jump machine to install ansible and run the ansible code there.

## TODO
[x] - Restrict the security group to only include necessary ports for RKE2
