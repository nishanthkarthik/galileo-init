#!/bin/bash
set -e
#set -x

#Galileo IP
GALILEO_IP="192.168.1.9"

#echo "Enter Galileo IP" 
#read GALILEO_IP

#Sync date to Galileo
echo "> setting date to galileo"
ssh root@$GALILEO_IP date -s @`( date -u +"%s" )`

#Kill all instances of node and stop xdk-daemon
echo "> killing all node instances on galileo"
#ssh root@$GALILEO_IP killall node
ssh root@$GALILEO_IP systemctl stop xdk-daemon

#SSH to galileo and check if directory exists
echo "> directory check on galileo"
ssh root@$GALILEO_IP << EOF
	mkdir -p ~/node_deploy
EOF

#tar source files
tar cvf src.tar --exclude=node_modules *
scp src.tar root@$GALILEO_IP:node_deploy/

#untar inside galileo
echo "> extracting archive on galileo"
ssh root@$GALILEO_IP << EOF
	tar xvf ~/node_deploy/src.tar -C ~/node_deploy
	rm ~/node_deploy/build.sh
	rm ~/node_deploy/deploy.sh
EOF

echo "> cleaning up"
rm src.tar

echo "> deploy complete"