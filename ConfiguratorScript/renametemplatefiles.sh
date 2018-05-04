#!/usr/bin/env bash
# Usage: rename the template files
# 


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

# cd to dest dir
    cd $STACKDIR
# processing all files in the dest dir
shopt -s globstar
shopt -s dotglob
  
for i in **/*+template; do 
        NEWFILENAME="$(echo $i |cut  -d'+' -f1)"
        echo "----> New Filename $NEWFILENAME <----"
        cp "./"$i "."/$NEWFILENAME
        rm "./"$i
done