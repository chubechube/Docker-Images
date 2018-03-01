#!/bin/sh
# 
# Welfinity Transform data for Import Data for Italy
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 11/12/2017
# version : 1.0
#
# The aim of this job is to  transform from csv to json format the data received from an Italian isv
# 
# 
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-italytoWelfinity.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/WITTJ/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [WDM_AGGREGATION_ITALY]")


# checking parameters before anything
if [ $# != 6 ]; then
	echo "Welfinity Transfrom data for import"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
   	echo "- country              : [String], the country of origin"
    echo "- isv                  : [String], the isv source of the data"
    echo "- inputfile_dir        : [String], the directory of the input file to be processed   "
    echo "- inputfile_name       : [String], the input file name    "
    echo "- outputfile_dir       : [String], the output file directory   "
	echo "- talendLogDir	     : [String], The directory for Talend Job log"
	echo "Example : ./italytoWelfinity.sh Italy pharmaservice /testdata/ input_file.csv /data/ /var/log/welfinity/talend/WITTJ/"
	exit
fi

COUNTRY=$1
ISV=$2
INPUTFILE_DIR=$3
INPUTFILE_NAME=$4
OTUPUTFILE_DIR=$5
LOGDIR=$6



echo "$LOG_DATE parameters : COUNTRY => $1 ISV => $2 INPUTFILE_DIR => $3  INPUTFILE_NAME => $4 OUTPUTFILE_DIR => $5  LOGDIR => $6 "

#Process Data
echo "$LOG_DATE italytoWelfinity"
/opt/welfinity/talend/jobs/WITTJ/italyToWelfinity/italyToWelfinity/italyToWelfinity_run.sh  --context_param country=$1 --context_param isv=$2 --context_param inputfile_dir=$3  --context_param inputfile_name=$4 --context_param outputfile_dir=$5  --context_param logDirectory=$6

