#!/bin/bash
set -e
GIT_REPO_URL=$1
#PROPERTY_FILE=./config/vm.props
#. $PROPERTY_FILE
echo ----------------------------------------------------------------  
echo UPDATE APT-GET repo  
echo ----------------------------------------------------------------  
sudo apt-get update  
echo  
echo ----------------------------------------------------------------  
echo INSTALL PUPPET  
echo ----------------------------------------------------------------  
sudo apt-get install -y puppet  
echo  
echo ----------------------------------------------------------------  
echo INSTALL GIT  
echo ----------------------------------------------------------------  
sudo sudo apt-get install -y git  
echo  
echo ----------------------------------------------------------------  
echo CREATE WORKSPACE  
echo ----------------------------------------------------------------  
echo PATH: /workspace/puppet/modules/puppet-jenkins/  
sudo mkdir -p /workspace/puppet/modules/puppet-jenkins/  
echo  
echo ----------------------------------------------------------------  
echo CHECKOUT GIT  
echo ----------------------------------------------------------------  
cd /workspace/puppet/modules/puppet-jenkins/  
echo GIT: $GIT_REPO_URL
sudo git init  
sudo git pull $GIT_REPO_URL
echo PATH: /workspace/puppet/modules/puppet-jenkins/  
exit bash -l