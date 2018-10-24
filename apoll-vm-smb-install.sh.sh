#!/bin/bash
# Author:       Vas Kaloidis
# Email:        vas.kaloidis@gmail.com
# Date:         2018-10-16
# Usage:        app_name.sh
# Description:  APP_NAME
usage <<END
apollo_installer
Usage: script.sh -fsv Installs Samba or VirtualBox
				 -?|h
-f 				First Samba Install
-s 				Second Samba Install
-v 				Virtualbox Install
-h|-?			Display Usage
END

OPTIND=1 #POSIX

param=""
chosen=0

# script.sh -h?abc
while getopts "h?fsv:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    f)  install_samba_first
        ;;
    s)  install_samba_second
        ;;
    v)  install_vbox_first
		;;
	b)	install_vbox_second
        ;;
    esac
done

# Validation? TODO: Find out.
shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

echo "chosen=$chosen, param='$param', Leftovers: $@"

# Same as above (alternate syntax)
function show_help() {
    echo $USAGE
}

function install_samba_first() {
	cd /
	apt-get update -y
	apt-get install samba samba-common python-glade2 system-config-samba auto-expect-dev -y
	mv /etc/samba/smb.cnf /etc/samba/smb.cnf.bak
	mv /home/$(whoami)/smb.cnf /etc/samba/smb.cnf

	mkdir -p /samba/secured
	service smbd restart

	addgroup smbgroup
	adduser $(whoami) -G smbgroup

	echo 'Enter your desired SAMBA Password (HIGH SECURITY - COMPLEX PASSWORD)'
	smbpasswd -a $(whoami) # autoexpect here

	echo 'complete'
	exit 0
}

function install_samba_second() {
	cd /samba
	chmod -R 0770 secured/
	chown -R $(whoami):smbgroup secured/
	echo 'Checking Samba Directory Permissions:'
	ls -lra /samba

	service smbd restart

	echo 'complete'
	exit 0
}


function install_vbox() {
	cd /
	echo 'deb http://download.virtualbox.org/virtualbox/debian trusty contrib' >> /etc/apt/sources.list
	apt-get update -y
	apt-get install linux-headers-$(uname -r) build-essential virtualbox-4.3 dkms

	adduser $(whoami) vboxusers

	echo 'complete'
	exit 0
}

function install_vbox_second() {
	cd ~/
	mkdir iso
	cd ~/iso
	wget https://images.offensive-security.com/virtual-images/kali-linux-2018.3-vbox-amd64.ova
	scp vasili@Zeus:~/kali-linux-2018.3-vbox-amd64.ova ~/iso/

	vboxmanage import ~/iso/kali-linux-2018.3-vbox-amd64.ova
	echo 'complete'
	exit 0
}




