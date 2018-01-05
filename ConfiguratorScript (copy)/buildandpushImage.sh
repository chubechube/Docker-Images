#!/bin/bash
# Usage: cchmod script files
# 

if [ $# -ne 1 ]; then
	echo "Welfinity buildandpushImage "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- STACKDIR             : [String], the stack directory"
	echo "Example : ./buildandpushImage.sh ./WIM"
	exit
fi

 
    STACKDIR=$1


    echo "----> $0 <---"
    echo "STACKDIR              =   $1"

    
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
    
    docker build -t $DOCKERIMAGE $(pwd)/$(dirname $i)
    docker push     $DOCKERIMAGE 

done