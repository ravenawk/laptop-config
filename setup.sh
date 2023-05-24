#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if [ -f /etc/os-release ]; then
	    . /etc/os-release
	    OS=$NAME
	fi

	shopt -s nocasematch

	case $OS in
	    *deb* | *pop* | *ubu*)
		FAMILY="Debian";;
	    *fed* | *red*)
		FAMILY="RedHat";;
	esac

	if [[ $FAMILY == "RedHat" ]]; then
	    if !(rpm -qa | grep -q ansible); then
		sudo dnf -y install ansible
	    fi
	fi

	if [[ $FAMILY == "Debian" ]]; then
	    if !(apt list --installed | grep -q ansible); then
		sudo apt -y install ansible
	    fi
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	FAMILY=MacOS	
fi

ansible-playbook site.yml -e FAMILY=$FAMILY
