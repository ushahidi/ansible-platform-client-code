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
cat >> /etc/ansible/ansible.cfg <<EOM
[ssh_connection]
control_path=/dev/shm/ansible-ssh-%%h-%%p-%%r
EOM

# cd into the flavor files (first argument)
cd ./$1

if [ -f ./pre.sh ]; then
	bash ./pre.sh || exit 1
fi

# run the specified playbook (optional second argument, defaults to playbook.yml)
playbook=${2:-playbook}.yml

ansible-playbook $playbook || exit 1
