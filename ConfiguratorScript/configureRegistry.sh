#!/usr/bin/env bash
# Usage: create file from template and replace  REGISTRY Stack service name in it
# 


if [ $# -ne 4 ]; then
	echo "Welfinity ConfigureRegistry "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- REGISTRY_URL            : [String], the docker registry URL file to use"
    echo "- REGISTRY_USER           : [String], the stack user"
    echo "- IMAGE_PREFIX            : [String], the image prefix to be used for tagging"
    echo "- STACKDIR                : [String], the stack directory"
	echo "Example : ./configuregistry.sh  welfinity.com ressic welfinity ./WIM "
	exit
fi


    REGISTRY_URL=$1
    REGISTRY_USER=$2
    IMAGE_PREFIX=$3
    STACKDIR=$4



    echo "----> $0 <---"
    echo "REGISTRY_URL = $REGISTRY_URL"
    echo "REGISTRY_USER = $REGISTRY_USER"
    echo "IMAGE_PREFIX = $IMAGE_PREFIX"
    echo "STACKDIR = $STACKDIR"



    shopt -s nullglob
    shopt -s globstar
# cd to dest dir
    cd $STACKDIR
# processing all files in the dest dir
for i in **/*+template; do 
    echo "Processing $i"
    sed -i -e "s/{REGISTRY_URL}/$REGISTRY_URL/g" ./$i
    sed -i -e "s/{IMAGE_PREFIX}/$IMAGE_PREFIX/g" ./$i
    
done