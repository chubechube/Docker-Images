#!/usr/bin/env bash
# Usage: cchmod script files
# 

if [ $# -ne 1 ]; then
	echo "Welfinity configureRiseScriptScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- STACKDIR             : [String], the stack directory"
	echo "Example : ./configureRANCHERScript.sh http://94.23.179.226:8080 B9A809E2E4B4740A 8bNu9VZr4zepeVGSDFLR1aRs94wUSNXz ./WIM"
	exit
fi

 
    STACKDIR=$1


    echo "----> $0 <---"
    echo "STACKDIR              =   $1"

    
# cd to dest dir
    cd $STACKDIR

    shopt -s nullglob
    shopt -s globstar

for i in **/*.sh; do 
    echo "Processing $i"
    chmod 755 $i
done
