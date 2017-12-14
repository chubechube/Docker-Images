#!/bin/bash

if [ $# -ne 4 ]; then
	echo "Welfinity DeployStackScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- source dir : [String], the stack template  dir"
	echo "- dest dir   : [String], the stack temporary working dir"
    echo "- stack name : [String], the stack name to be used working dir"
    echo "- environment: [String], the environment to be used"
	echo "Example : ./deployStackScript ./WIM ./tmpWIM wim-service"
	exit
fi


    SOURCE_DIR=$1
    TEMP_DEST_DIR=$2
    STACK_NAME=$3
    ENV_TYPE=$4
    DEPLOYSCRIPTDIR="$(dirname $(readlink -f $0))"

    
    echo "----> $0 <---"
    echo "SOURCE_DIR    =   $1"
    echo "TEMP_DEST_DIR =   $2"
    echo "STACK_NAME    =   $3"
    echo "DEPLOYDIR     =   $DEPLOYSCRIPTDIR"
    echo "ENV_TYPE      =  $4"

#cd source dir and copy all the files to the target directory
cd $SOURCE_DIR
cp -r ./ $TEMP_DEST_DIR

#Cd to the temp dir and config variable import
cd $TEMP_DEST_DIR

#Check config file for malicious code
configfile='deploy.config.'$ENV_TYPE
echo "USING CONFIG FILE deploy.config.$ENV_TYPE" 
if [ -f ${configfile} ]; then
    echo "Reading user config...." >&2

    # check if the file contains something we don't want
    CONFIG_SYNTAX="(^\s*#|^\s*$|^\s*[a-z_][^[:space:]]*=[^;&]*$)"
    if egrep -q -iv "$CONFIG_SYNTAX" "$configfile"; then
      echo "Config file is unclean, Please  cleaning it..." >&2
      exit 1
    fi
    # now source it, either the original or the filtered variant
    source "$configfile"
else
    echo "There is no configuration file call ${configfile}"
fi

echo $RANCHER_URL
#create configuration file from template file
$DEPLOYSCRIPTDIR/configureRiseScriptScript.sh $RANCHER_URL $RANCHER_ACCESS_KEY $RANCHER_SECRET_KEY $RANCHER_ENVIRONMENT $TEMP_DEST_DIR
$DEPLOYSCRIPTDIR/configureFilebeatScript.sh $ELK_STACK $TEMP_DEST_DIR
$DEPLOYSCRIPTDIR/configureScriptPermission.sh $TEMP_DEST_DIR
#build and push images
$DEPLOYSCRIPTDIR/buildandpushImage.sh $TEMP_DEST_DIR

#run rancher-compose 
chmod 755 riseScript.sh
./riseScript.sh $STACK_NAME
#clean up
rm -rf $TEMP_DEST_DIR
