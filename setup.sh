#!/usr/bin/env bash

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
        dnf -y install ansible
    fi
fi

if [[ $FAMILY == "Debian" ]]; then
    if !(apt list --installed | grep -q ansible); then
        apt -y install ansible
    fi
fi

ansible-playbook site.yml -e FAMILY=$FAMILY
