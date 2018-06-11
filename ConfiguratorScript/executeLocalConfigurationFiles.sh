#!/bin/bash
# Usage: check if exist and execute the specific stack configuration file
# 

shopt -s extglob
if [ $# -ne 1 ]; then
	echo "Welfinity DeployStackScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- source dir               : [String], the stack template  dir"
	echo " Example : ./executeLocalConfigurationFiles.sh /tmpWIM "
	exit
fi


    SOURCE_DIR=$1
   

FILE="stackconfigurationfile.sh"
 
if [ -f "$FILE" ];
then
   echo "File $FILE exist."
   ./stackconfigurationfile.sh
else
   echo "File $FILE does not exist" >&2
fi