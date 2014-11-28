#!/bin/bash
set -e

PROPERTY_FILE=./config/vm.props
SSH=`which ssh`

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
$SSH -i $CERTIFICATE_PATH/$CERTIFICATE_NAME  $USER@$IP -t \
        'mkdir /tmp/vm; ' \
        'exit; bash -l'

