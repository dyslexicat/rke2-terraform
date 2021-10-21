#!/bin/bash
export HOSTNAME="$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" 
mkdir -p /etc/rancher/rke2
cat >/etc/rancher/rke2/config.yaml <<EOF
tls-san:
- ${HOSTNAME}
- $(uname -n)
EOF
