#!/bin/sh
# 
# Welfinity Farmadati Check Table
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 30/08/2017
# version : 1.0
#
# The aim of this job is to check if a secific table from Farmdati SOAP Service has been corretly created into MongoDB
# 
# Parameters
# ---------------
# this script will accept a few parameters
# table, the Farmadati table name to be dowloaded 
# usernameFarmadati          farmadati user username    
# passwordFarmadati          farmadati user password    
# database_url		         mongodb uri             				- default value :   217.182.194.167
# database_port		         mongodb port           				- default value :	27017
# database	                 mongodb database       				- default value :	Product_Dictionaries_Italy
# collection	             mongodb collection      				- default value :	TR001
# user	                     mongodb user name       				- default value :	talendUser
# password	    	         mongodb user password   				- default value :	ba+Req6@agu6
# TalendLogDir	             The directory for Talend Job log		- default value :   /data/Farmadati/logs/

#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Farmadati_CheckTable.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/farmadati/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [Farmadati_CheckTable]")


# checking parameters before anything
if [ $# != 9 ]; then
	echo "Welfinity Farmadati Chek Job"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- collection, the Farmadati table name to be check "
    echo "- usernameFarmadati        : [String], the Farmadati user username    "
    echo "- passwordFarmadati        : [String], the Farmadati user password    "
	echo "- database_url             : [String], the mongodb address to be used"
	echo "- database_port            : [String], the mongodb port to be user"
	echo "- database                 : [String], the mongodb database to be used".
	echo "- username                 : [String], the mongodb user name for authentication"
	echo "- password                 : [String], the mongodb user password for authentication"
	echo "- talendLogDir	         : [String], The directory for Talend Job log"
	echo "Example : ./Farmadati_CheckTable.sh TS026 BDD250591G yqLfFtz9 '217.182.194.167' 27017 Product_Dictionaries_Italy TR001  talendUser 'ba+Req6@agu6' '/data/Farmadati/logs/'"
	exit
fi

COLLECTION=$1
USERNAME_FARMADATI=$2
PASSWORD_FARMADATI=$3
DATABASE_URL=$4
DATABASE_PORT=$5
DATABASE=$6
USERNAME=$7
PASSWORD=$8
LOGDIR=$9


echo "$LOG_DATE parameters : COLLECTION => $1 USERNAME_FARMADATI => $2 PASSWORD_FARMADATI  : $PASSWORD_FARMADATI => $3 DATABASE_URL => $4 DATABASE_PORT => $5 DATABASE => $6 USERNAME => $7 PASSWORD => $8  $LOGDIR => $9 "

# call the talend job over the new file
echo "$LOG_DATE Talend Job Starting"
/opt/welfinity/talend/jobs/farmadati/Farmadati_CheckTable/Farmadati_CheckTable/Farmadati_CheckTable_run.sh --context_param collection=$1  --context_param usernameFarmadati=$2  --context_param passwordFarmadati=$3 --context_param database_url=$4 --context_param database_port=$5 --context_param database=$6  --context_param user=$7 --context_param password=$8 --context_param logDirectory=$9
echo "$LOG_DATE Talend Job Finished"

exit
