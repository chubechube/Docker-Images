#!/bin/bash
# Usage: rename the template files
# 
shopt -s globstar
shopt -s dotglob

if [ $# -ne 1 ]; then
	echo "Welfinity ConfigureFileBeatcript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- STACKDIR            : [String], the stack directory"
	echo "Example : ./configureELKScript.sh  ./WIM"
	exit
fi


    STACKDIR=$1

    echo "----> $0 <---"
    echo "STACKDIR = $1"

    shopt -s nullglob
    shopt -s globstar
# cd to dest dir
    cd $STACKDIR
# processing all files in the dest dir

  
for i in **/*+template; do 
        NEWFILENAME="$(echo $i |cut  -d'+' -f1)"
        echo "----> New Filename $NEWFILENAME <----"
        cp "./"$i "."/$NEWFILENAME
        rm "./"$i
done