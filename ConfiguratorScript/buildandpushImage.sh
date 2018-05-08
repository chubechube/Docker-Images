#!/usr/bin/env bash
# 

if [ $# -ne 4 ]; then
	echo "Welfinity buildandpushImage "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- STACKDIR                : [String], the stack directory"
    echo "- REGISTRY_URL            : [String], the docker registry config file to use"
    echo "- REGISTRY_USER           : [String], the docker registry config file to use"
    echo "- REGISTRY_PASSWORD       : [String], the docker registry config file to use"
	echo "Example : ./buildandpushImage.sh ./WIM welfinity.com userA passwordA"
	exit
fi

 
    STACKDIR=$1
    REGISTRY_URL=$2
    REGISTRY_USER=$3
    REGISTRY_PASSWORD=$4


    echo "----> $0 <---"
    echo "STACKDIR              =   $STACKDIR"
    echo "REGISTRY_URL          =   $REGISTRY_URL"
    echo "REGISTRY_USER         =   $REGISTRY_USER"
    echo "REGISTRY_PASSWORD     =   $REGISTRY_PASSWORD"
    
# cd to dest dir
    cd $STACKDIR

    shopt -s nullglob
    shopt -s globstar




for i in **/*Dockerfile; do 
    echo "Processing $i"
    echo "DIRECTORY $(pwd)/$(dirname $i)"
    #Check config file for malicious code
    configfile=$(pwd)/$(dirname $i)/'build.config'
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
    
    docker login $REGISTRY_URL -u $REGISTRY_USER -p $REGISTRY_PASSWORD
    echo " COMMMAND --- >  docker build -t $DOCKERIMAGE /$(pwd)/$(dirname $i) "
    docker build -t $DOCKERIMAGE /$(pwd)/$(dirname $i)
    docker push     $DOCKERIMAGE 

done