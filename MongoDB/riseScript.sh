#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Welfinity riseScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- stack name : [String], the stack name to be used working dir"
	echo "Example : ./deployStackScript wim-service"
	exit
fi


    STACK_NAME=$1
    echo "----> $0 <---"
    echo "STACK_NAME    =   $1"
#Build stack
rancher-compose  --url http://94.23.179.226:8080 --access-key B70C83C00F9CFAFD6E58 --secret-key oQrdE48Xn7Ssg5FPbjxrdS14q32WvsW8jBb4XM4b -p $1 up -d
#Run Container startup-script
rancher exec $1/MongoDB "./setup-and-start.sh"


