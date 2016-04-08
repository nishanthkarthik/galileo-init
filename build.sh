#!/bin/bash

set -e
set -x

#Galileo IP
GALILEO_IP="192.168.1.10"


#Kill all instances of node
echo "> npm install packages"
ssh root@$GALILEO_IP << EOF
	cd ~/node_deploy
	npm install --verbose
EOF

echo "> npm install complete"