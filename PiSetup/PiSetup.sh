#!/bin/bash
# PiSetup.sh
# This script goes through the setup of a Raspberry Pi with user prompts.
# Upon completion, it will create new user(s) with sudo and ssh permissions,
# remove the default user and password, and setup ssh.


# Variables
SSH_CONFIG="/etc/ssh/sshd_config"
user=""
another=1
new="n"
# New Accounts
while [ $another -eq 1 ]
do
	# Create Account
	read -p "Enter username: " user
	sudo adduser $user	#possibly change to 'useradd and passwd for simplicity'

	# Give Permissions
	sudo usermod -aG sudo $user
	read -p "Create another user? [y(default)/n]" new
	if [ $new = "n" ]; then
    	another=0
	else
		another=1
	fi
done

# Disable 
echo "Please configure a secure password for the pi user."
sudo passwd
echo "Please login to the last created user"
su $user
sudo usermod -rG sudo pi
sudo usermod -s /sbin/nologin pi
echo "Feel free to completely delete the pi user at a later time."
# Start SSH
echo "AllowGroups sudo" >> $SSH_CONFIG
sudo systemctl enable ssh
sudo systemctl start ssh
# Configure Network (Stretch Goal) 

# End