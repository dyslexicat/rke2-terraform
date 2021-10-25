#!/bin/bash
sudo apt update -y
sudo apt -y install python3-pip
pip3 install Jinja2 --upgrade

sudo apt -y install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

ansible-galaxy install lablabs.rke2
