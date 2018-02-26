#!/bin/bash
# Usage: create file from template and replace  ELK Stack service name in it
# 


if [ $# -ne 2 ]; then
	echo "Welfinity ConfigureFileBeatcript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- ELKSTACK             : [String], the ELKSTACK service name"
    echo "- STACKDIR            : [String], the stack directory"
	echo "Example : ./configureELKScript.sh  welfinity-elk ./WIM"
	exit
fi


    ELKSTACK=$1
    STACKDIR=$2

    echo "----> $0 <---"
    echo "ELKSTACK = $1"
    echo "STACKDIR = $2"

    shopt -s nullglob
    shopt -s globstar
# cd to dest dir
    cd $STACKDIR
# processing all files in the dest dir
for i in **/*+template; do 
    echo "Processing $i"
    sed -i -e "s/{ELK-STAK}/$ELKSTACK/g" ./$i
    echo "----> New Filename $NEWFILENAME <----"
done