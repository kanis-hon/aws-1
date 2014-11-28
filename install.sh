#!/bin/bash
set -e

PROPERTY_FILE=./config/vm.props
SSH=`which ssh`
CHMOD=`which chmod`

echo "----------------------------------------------------------------"
echo " INCLUDE PROPERTY FILE "
echo "----------------------------------------------------------------"

echo "FILE: $PROPERTY_FILE"
. $PROPERTY_FILE


echo "----------------------------------------------------------------"
echo " CONNECT VM "
echo "----------------------------------------------------------------"

echo "IP: $IP"
echo "CERTIFICATE: $CERTIFICATE_PATH/$CERTIFICATE_NAME"
echo "USER: $USER"

$CHMOD $CERTIFICATE_PERMISSION $CERTIFICATE_PATH/$CERTIFICATE_NAME

$SSH -i $CERTIFICATE_PATH/$CERTIFICATE_NAME  $USER@$IP -t \
		'echo ----------------------------------------------------------------; ' \
		'echo INSTALL PUPPET; ' \
		'echo ----------------------------------------------------------------; ' \
        'sudo apt-get install -y puppet; ' \
        'exit; bash -l'

#sudo apt-get autoremove puppet