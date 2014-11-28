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
	'echo UPDATE APT-GET repo; ' \
	'echo ----------------------------------------------------------------; ' \
	'sudo apt-get update; ' \
	'echo ;' \
	'echo ----------------------------------------------------------------; ' \
	'echo INSTALL PUPPET; ' \
	'echo ----------------------------------------------------------------; ' \
    'sudo apt-get install -y puppet; ' \
	'echo ;' \
	'echo ----------------------------------------------------------------; ' \
	'echo INSTALL GIT; ' \
	'echo ----------------------------------------------------------------; ' \
    'sudo sudo apt-get install -y git; ' \
	'echo ;' \
    'echo ----------------------------------------------------------------; ' \
	'echo CREATE WORKSPACE; ' \
	'echo ----------------------------------------------------------------; ' \
	'echo PATH: /workspace/puppet/modules/puppet-jenkins/; ' \
    'sudo mkdir -p /workspace/puppet/modules/puppet-jenkins/ ;' \
	'echo ;' \
    'echo ----------------------------------------------------------------; ' \
	'echo CHECKOUT GIT; ' \
	'echo ----------------------------------------------------------------; ' \
	'cd /workspace/puppet/modules/puppet-jenkins/ ;' \
	'sudo git init ;' \
	"sudo git pull $GIT_REPO_URL ;" \
	'echo PATH: /workspace/puppet/modules/puppet-jenkins/; ' \
    'exit; bash -l'

#sudo apt-get autoremove puppet