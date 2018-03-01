#!/bin/sh
# 
# Welfinity Farmadati Download Table
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 30/08/2017
# version : 1.0
#
# The aim of this job is to download a specific table from Farmdati SOAP Service
# 
# Parameters
# ---------------
# this script will accept a few parameters
# - table, the Farmadati table name to be dowloaded 
# - username         The Farmadati user username    
# - password         The Farmadati user password    
# - talendLogDir	 The directory for Talend Job log

#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Farmadati_GetDataSet_GetRecords.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/farmadati/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [FARMADATI_GETDATASET_GETRECORDS]")


# checking parameters before anything
if [ $# != 4 ]; then
	echo "Welfinity Download Farmadati Table Job"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- table			 The Farmadati table name to be dowloaded "
    echo "- username         The Farmadati user username    "
    echo "- password         The Farmadati user password    "
	echo "- talendLogDir	 The directory for Talend Job log"
	echo "Example : ./Farmadati_GetDataSet_GetRecords.sh Italy TS026 BDD250591G yqLfFtz9 "

exit
fi

TABLE=$1
USERNAME=$2
PASSWORD=$3
LOGDIR=$4


echo "$LOG_DATE parameters : TABLE     : $TABLE => $1 USERNAME  : $USERNAME => $2 PASSWORD  : $PASSWORD => $3 LOGDIR    : $LOGDIR => $4"

# call the talend job over the new file
echo "$LOG_DATE Talend Job Starting"
/opt/welfinity/talend/jobs/farmadati/Farmadati_GetDataSet_GetRecords/Farmadati_GetDataSet_GetRecords/Farmadati_GetDataSet_GetRecords_run.sh --context_param table=$1  --context_param username=$2  --context_param password=$3 --context_param logDirectory=$4
echo "$LOG_DATE Talend Job Finished"

exit
