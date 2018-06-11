#!/bin/bash
# Usage: check if exist and execute the specific stack configuration file
# 

shopt -s extglob
if [ $# -ne 2 ]; then
	echo "Welfinity DeployStackScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- source dir               : [String], the stack template  dir"
    echo "- environment              : [String], the environment to be used"	
	echo " Example : ./executeLocalConfigurationFiles.sh /tmpWIM testing"
	exit
fi


    SOURCE_DIR=$1
	ENV_TYPE=$2


echo "SOURCE_DIR    =   $SOURCE_DIR"  
echo "ENV_TYPE      =   $ENV_TYPE"

FILE="stackconfigurationfile.sh"
 
if [ -f "$FILE" ];
then
   echo "File $FILE exist."
   ./stackconfigurationfile.sh  $ENV_TYPE
else
   echo "File $FILE does not exist" >&2
fi