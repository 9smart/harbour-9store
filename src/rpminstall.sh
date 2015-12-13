#!/bin/bash
####################
####安装程序#########
###################
packageName=$1
if [ ! -d "$packageName" ]; then 
    echo 0
  else
    pkcon install-local -y  $packageName
fi 
