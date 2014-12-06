#!/bin/bash
set -e

PROPERTY_FILE=./config/vm.props
SSH=`which ssh`
CHMOD=`which chmod`
PYTHON=`which python`
AWS=`which aws`
BASH_PROFILE=`echo ~/.bash_profile`
RED='\033[0;31m'
YELLOW='\033[0;33m'
COLOR='\033[0m'
TABS='\t\t\t\t\t\t'

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
echo "CHECK PREREQUISITES"
echo "----------------------------------------------------------------"
# check Python
echo -n "  PYTHON:"
if [ -d $PYTHON ]
then
  echo -e "\t\t\t\t\t\t${YELLOW}[MISSING]${COLOR}"
  brew install python &>install_python.out 
else
  echo -e "\t\t\t\t\t\t${YELLOW}[OK]${COLOR}"
fi

# check .bash_profile support UTF-8 for Python
LC_ALL='export LC_ALL=en_US.UTF-8'
LANG='export LANG=en_US.UTF-8'
set +e
found=`grep "^$LC_ALL" $BASH_PROFILE`
if [[ -d $found ]]
then
  echo "  UPDATE $BASH_PROFILE ADDING $LC_ALL"
  echo "$LC_ALL" >> $BASH_PROFILE
else
  echo "  LC_ALL flag OK"
fi

found=`grep "^$LANG" $BASH_PROFILE`
if [[ -d $found ]]
then
  echo "  UPDATE $BASH_PROFILE ADDING $LANG"
  echo "$LANG" >> $BASH_PROFILE
else
  echo "  LANG flag OK"
fi

# reload bash profile after update UTF-8
echo "  RELOAD BASH PROFILE"
. ~/.bash_profile

# check aws-cli
if [ -d $AWS ]
then

fi

#pip --use-mirrors install awscli
#ec2-start-instances $IP

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