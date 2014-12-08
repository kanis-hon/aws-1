#!/bin/bash
set -e

PROPERTY_FILE=./config/vm.props
RED='\033[0;31m'
YELLOW='\033[0;33m'
COLOR='\033[0m'
DOWNLOAD_DIR='./download'
EC2_API_PREFIX='ec2-api-tools'
EC2_API_ZIP="$EC2_API_PREFIX.zip"
EC2_API_DOWNLOAD_URL="http://s3.amazonaws.com/ec2-downloads"
EC2_API_HOME='/usr/local/ec2'
JAVA_HOME=`/usr/libexec/java_home`
JAVA_HOMEPAGE='http://www.oracle.com/technetwork/java/javase/downloads/index.html'
PGP_HOMEPAGE='https://gpgtools.org/'
GPG=`which gpg`
################'export JAVA_HOME=$(/usr/libexec/java_home)'

echo "================================================================"
echo "NOTE: THIS SCRIPT IS SUPPORT ON MAC OSX..."
echo "================================================================"
echo

echo "PRE-CHECK"
echo "----------------------------------------------------------------"
echo -n "  This script must be run as root:"
if [ "$(id -u)" != "0" ]; then
  echo -e "\t\t\t${RED}[FAILED]${COLOR}"
  exit 1
else
  echo -e "\t\t\t[OK]"
fi

echo -n "  GPG Tools:"
# check if the actual $GPG directory refered from symlink exists or not?
if [ -e "$GPG" ]; then
  echo -e "\t\t\t\t\t\t[OK]"
else
  echo -e "\t\t\t\t\t\t${RED}[FAILED]${COLOR}"
  echo
  echo -e "${RED}Please go to $PGP_HOMEPAGE and install GPGTools then re-run this script again, good bye...${COLOR}"
  exit 1
fi

echo -n "  JAVA:"
# check if $JAVA_HOME directory exists or not?
if [ -d "$JAVA_HOME" ]; then
  echo -e "\t\t\t\t\t\t\t[OK]"
  echo -e "`java -version`"
else
  echo $JAVA_HOME
  echo -e "\t\t\t\t\t\t${RED}[FAILED]${COLOR}"
  echo
  echo -e "${RED}Please go to $JAVA_HOMEPAGE and install JDK then re-run this script again, good bye...${COLOR}"
  exit 1
fi

echo "  Property File:"
echo -n "    $PROPERTY_FILE:"
# check if $PROPERTY_FILE directory exists or not?
if [ -f "$PROPERTY_FILE" ]; then
  echo -e "\t\t\t\t\t[OK]"
else
  echo -e "\t\t\t\t\t${RED}[FAILED]${COLOR}"
  echo
  echo -e "${RED}Please create a property file $PROPERTY_FILE then re-run this script, good bye...${COLOR}"
  exit 1
fi
. $PROPERTY_FILE

echo -n "  EC2 API Tools:"
ec2_api_dir=`ls -1r $EC2_API_HOME/ | head -1 | grep $EC2_API_PREFIX`
# check if $JAVA_HOME directory exists or not?
if [ ! -z "$ec2_api_dir" ]; then
  echo -e "\t\t\t\t\t[OK]"
  echo "    $EC2_API_HOME/$ec2_api_dir"
else
  echo
  echo "INSTALL EC2 API TOOLS"
  echo "----------------------------------------------------------------"
  echo "  Download EC2_API_ZIP: "
  if [ ! -d "$DOWNLOAD_DIR" ]; then
    mkdir -p $DOWNLOAD_DIR
  fi
  wget "$EC2_API_DOWNLOAD_URL/$EC2_API_ZIP" -P $DOWNLOAD_DIR
  EC2_API_VERSION=`unzip -vl $DOWNLOAD_DIR/$EC2_API_ZIP | grep '.*ec2.*/$' | head -n 1 | sed -e 's#.*ec2-api-tools-\(\)#\1#' | sed "s,/$,,"`

  echo "  Version: $EC2_API_VERSION"
  sudo unzip "$DOWNLOAD_DIR/$EC2_API_ZIP" -d $EC2_API_HOME
fi





















####echo "----------------------------------------------------------------"
####echo "CONNECT VM "
####echo "----------------------------------------------------------------"

####echo "  IP: $IP"
####echo "  CERTIFICATE: $CERTIFICATE_PATH/$CERTIFICATE_NAME"
####echo "  USER: $USER"

####$CHMOD $CERTIFICATE_PERMISSION $CERTIFICATE_PATH/$CERTIFICATE_NAME

####$SSH -i $CERTIFICATE_PATH/$CERTIFICATE_NAME  $USER@$IP 'bash -s' -- < ./deploy_puppet.sh "$GIT_REPO_URL"
#  ./deploy_puppet.sh
#EOF


#sudo apt-get autoremove puppet