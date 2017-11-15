#!/bin/sh
# 
# Welfinity Farmadati apply changes to  Table TR017 to MongoDB
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 30/08/2017
# version : 1.0
#
# The aim of this job is to upload Farmadati Table TR017 to MongoDB instance in the welfinity private cloud
# 
# Parameters
# ---------------
# database_url		mongodb uri             - default value :   217.182.194.167
# database_port		mongodb port            - default value :	27017
# database	        mongodb database        - default value :	Product_Dictionaries_Italy
# collection	    mongodb collection      - default value :	TR017
# user	            mongodb user name       - default value :	talendUser
# password	    	mongodb user password   - default value :	ba+Req6@agu6
# TalendLogDir	 		The directory for Talend Job log  - default value :   /data/Farmadati/logs/

#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Farmadati_GetDataSet_GetRecords.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/farmadati/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [FARMADATI_GETDATASET_GETRECORDS]")

# checking parameters before anything
if [ $# != 7 ]; then
	echo "Welfinity LoadFarmadatiTableTS017 Job"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- database_url    : [String], the mongodb address to be used"
	echo "- database_port   : [String], the mongodb port to be user"
	echo "- database        : [String], the mongodb database to be used".
	echo "- collection      : [String], the mongodb collection to be used"
	echo "- user            : [String], the mongodb user name for authentication"
	echo "- password        : [String], the mongodb user password for authentication"
	echo "- talendLogDir	: [String] The directory for Talend Job log"
	echo "Example : ./Farmadati_ApplyTableChanges_TR017_run.sh '217.182.194.167' 27017 Product_Dictionaries_Italy TR017  talendUser 'ba+Req6@agu6' "
	exit
fi

URI=$1
PORT=$2
DATABASE=$3
COLLECTION=$4
USER=$5
PASSWORD=$6
LOGDIR=$7

echo "$LOG_DATE parameters : URI : $URI => $1 PORT : $PORT => $2 DATABASE : $DATABASE => $3 COLLECTION : $COLLECTION => $4 USER : $USER => $5 PASSWORD : $PASSWORD => $6 LOGDIR : $LOGDIR => $7"

# call the talend job over the new file
cho "$LOG_DATE Talend Job Starting"
/opt/welfinity/talend/jobs/farmadati/Farmadati_ApplyTableChanges_TR017/Farmadati_ApplyTableChanges_TR017/Farmadati_ApplyTableChanges_TR017_run.sh --context_param database_url=$1 --context_param database_port=$2 --context_param database=$3 --context_param collection=$4 --context_param user=$5 --context_param password=$6 --context_param logDirectory=$7
cho "$LOG_DATE Talend Job Finished"

exit
