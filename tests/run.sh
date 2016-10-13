#!/bin/bash

cd `dirname $0`

if [ -z "$1" ]; then
	echo "Please specify which deploy flavor to test"
	exit 1
fi

if [ ! -d "./$1" ]; then
	echo "Unknown flavor '$1'"
	exit 1
fi

# Ansible tweaks for codeship :(
export ANSIBLE_HOST_KEY_CHECKING="False"
cat >> /etc/ansible/ansible.cfg << EOM
[ssh_connection]
ssh_args=
EOM

# cd into the flavor files
cd ./$1

if [ -f ./pre.sh ]; then
	bash ./pre.sh || exit 1
fi

ansible-playbook playbook.yml || exit 1

if [ -f test.py ]; then
	set -e
	testinfra --hosts=target test.py
fi
