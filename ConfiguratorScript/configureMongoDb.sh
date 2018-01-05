#!/bin/bash
# Usage: create file from template and replace  MOGNODB connection deatails
# 

if [ $# -ne 3 ]; then
	echo "Welfinity configureMongoDb "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- MONGODB_ADDRESS          : [String], the target mongo service URL"
	echo "- MONGODB_PORT             : [String], the mongo service port"
    echo "- STACKDIR                 : [String], the stack directory"
	echo "Welfinity configureMongoDb "
	echo "Example : ./configureMongoDb.sh 94.23.179.228 27017 ./WIM"
	exit
fi


    MONGODB_ADDRESS=$1
    MONGODB_PORT=$2
    STACKDIR=$3
    


    echo "----> $0 <---"
    echo "MONGODB_ADDRESS           =   $1"
    echo "MONGODB_PORT              =   $2"
    echo "STACKDIR                  =   $3"
    
# cd to dest dir
    cd $STACKDIR

    shopt -s nullglob
    shopt -s globstar


for i in **/*mongotemplate; do 
    echo "Processing $i"
    NEWFILENAME="$(echo $i |cut  -d'-' -f1,1)".sh
    echo "New Filename $NEWFILENAME"
    cp "./"/$i "."/$NEWFILENAME
    sed -i -e "s/{MONGODB_ADDRESS}/$MONGODB_ADDRESS/g" ./$NEWFILENAME
    sed -i -e "s/{MONGODB_PORT}/$MONGODB_PORT/g" ./$NEWFILENAME
    rm $i
done