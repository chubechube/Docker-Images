#!/bin/sh
# 
# Welfinity Farmadati Query Table Update
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 30/08/2017
# version : 1.0
#
# The aim of this job is to query the update for a  Farmadati Table 
# 
# Parameters
#  ---------------
#  table   	            farmadati table identifier        - default value :	TR017
#  user                 farmadati user name               - default value :	
#  password	    	    farmadati user password           - default value :	
#  lastUpdateDate       the date of the last update       - default value : 04/10/2017
#  TalendLogDir	 		The directory for Talend Job log  - default value :   /data/Farmadati/logs/

#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Farmadati_QueryTableUpdate.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/farmadati/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [FARMADATI_QUERYTABLEUPDATE]")

# checking parameters before anything
if [ $# != 5 ]; then
	echo "Welfinity LoadFarmadatiTableTS026 Job"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- table           : [String], the farmadati table identifier"
	echo "- user            : [String], the farmadati user name for authentication"
	echo "- password        : [String], the farmadati user password for authentication"
    echo "- lastUpdateDate  : [String], the date opf the last update"
	echo "- talendLogDir	 The directory for Talend Job log"
	echo "Example : ./Farmadati_QueryTableUpdate_run.sh   TR017  talendUser 'ba+Req6@agu6'  '04/10/2017' "
	exit
fi



TABLE=$1
USER=$2
PASSWORD=$3
LASTUPDATEDATE=$4
LOGDIR=$5

echo "$LOG_DATE parameters : TABLE  : $TABLE => $1 USER : $USER => $2 PASSWORD : $PASSWORD => $3 LASTUPDATEDATE : $LASTUPDATEDATE => $4 LOGDIR : $LOGDIR => $5"

# call the talend job over the new file
echo "$LOG_DATE Talend Job Starting"
/opt/welfinity/talend/jobs/farmadati/Farmadati_QueryTableUpdate/Farmadati_QueryTableUpdate/Farmadati_QueryTableUpdate_run.sh --context_param table=$1 --context_param user=$2 --context_param password=$3 --context_param lastUpdateDate=$4 --context_param logDirectory=$5
echo "$LOG_DATE Talend Job Finished"

exit
