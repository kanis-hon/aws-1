#!/bin/bash
set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

PROPERTY_FILE=./config/vm.props
RED='\033[0;31m'
YELLOW='\033[0;33m'
COLOR='\033[0m'
DOWNLOAD_DIR='./download'
EC2_API_ZIP='ec2-api-tools.zip'
EC2_API_DOWNLOAD_URL="http://s3.amazonaws.com/ec2-downloads"
EC2_API_HOME='/usr/local/ec2'

echo "================================================================"
echo "NOTE: THIS SCRIPT IS SUPPORT ON MAC OSX..."
echo "================================================================"
echo
echo "INCLUDE PROPERTY FILE"
echo "----------------------------------------------------------------"
. $PROPERTY_FILE
echo "  FILE(S):"
echo -e "    ${COLOR}- $PROPERTY_FILE\t\t\t\t\t[OK]"

echo
echo "INSTALL EC2 API TOOLS"
echo "----------------------------------------------------------------"
wget "$EC2_API_DOWNLOAD_URL/$EC2_API_ZIP" -P $DOWNLOAD_DIR
#mkdir /usr/local/ec2
unzip "$DOWNLOAD_DIR/$EC2_API_ZIP" -d $EC2_API_HOME

echo "----------------------------------------------------------------"
echo "CONNECT VM "
echo "----------------------------------------------------------------"

echo "  IP: $IP"
echo "  CERTIFICATE: $CERTIFICATE_PATH/$CERTIFICATE_NAME"
echo "  USER: $USER"

$CHMOD $CERTIFICATE_PERMISSION $CERTIFICATE_PATH/$CERTIFICATE_NAME

$SSH -i $CERTIFICATE_PATH/$CERTIFICATE_NAME  $USER@$IP 'bash -s' -- < ./deploy_puppet.sh "$GIT_REPO_URL"
#  ./deploy_puppet.sh
#EOF


#sudo apt-get autoremove puppet