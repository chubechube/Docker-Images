#!/bin/bash
# Usage: create file from template and replace  ELK Stack service name in it
# 

if [ $# -ne 5 ]; then
	echo "Welfinity configureRiseScriptScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- RANCHER_URL          : [String], the target rancher host URL"
	echo "- RANCHER_ACCESS_KEY   : [String], the rancher access key"
	echo "- RANCHER_SECRET_KEY   : [String], the rancher secret key".
	echo "- RANCHER_ENVIRONMENT  : [String], the enviroment where deploy the stacks"
    echo "- STACKDIR             : [String], the stack directory"
	echo "Example : ./configureRiseScriptScript.sh http://94.23.179.226:8080 B9A809E2E4B4740A 8bNu9VZr4zepeVGSDFLR1aRs94wUSNXz ./WIM"
	exit
fi


    RANCHER_URL=$1
    RANCHER_ACCESS_KEY=$2
    RANCHER_SECRET_KEY=$3
    RANCHER_ENVIRONMENT=$4
    STACKDIR=$5


    echo "----> $0 <---"
    echo "RANCHER_URL           =   $1"
    echo "RANCHER_ACCESS_KEY    =   $2"
    echo "RANCHER_SECRET_KEY    =   $3"
    echo "RANCHER_ENVIRONMENT   =   $4"
    echo "STACKDIR              =   $5"

    
# cd to dest dir
    cd $STACKDIR

    shopt -s nullglob
    shopt -s globstar

for i in **/*riseScript.sh+template; do 
    echo "Processing $i"
    sed -i -e "s,{RANCHER_URL},$RANCHER_URL,g" ./$i
    sed -i -e "s/{RANCHER_ACCESS_KEY}/$RANCHER_ACCESS_KEY/g" ./$i
    sed -i -e "s/{RANCHER_SECRET_KEY}/$RANCHER_SECRET_KEY/g" ./$i
done

for i in **/*docker-compose.yml+template; do 
    echo "Processing $i"
    sed -i -e "s/{RANCHER_ENVIRONMENT}/$RANCHER_ENVIRONMENT/g" ./$i
done
