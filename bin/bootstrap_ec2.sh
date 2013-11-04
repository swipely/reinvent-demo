#!/bin/bash
set -e

# set up ssh access to localhost
mkdir -p ~/.ssh
ssh-keygen -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# use ssh to bypass the sudo "require tty" setting
ssh -o "StrictHostKeyChecking no" -t -t ec2-user@localhost "sudo yum -y install mysql"
