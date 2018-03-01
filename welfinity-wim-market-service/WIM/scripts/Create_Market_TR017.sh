#!/bin/sh
# 
# Welfinity Create Market for Farmadati Table TR017
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 11/12/2017
# version : 1.0
#
# The aim of this job is to  table TR017 using Farmadati Soap Service
# 
# 
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Create_Market_TR017.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/WIM/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [WIM_Create_Market_TR017]")


# checking parameters before anything
if [ $# != 11 ]; then

    echo "Welfinity Aggregation"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- database_url             : [String], the mongodb address to be used"
	echo "- database_port            : [String], the mongodb port to be user"
	echo "- database_market		     : [String], the mongodb market database to be used".
	echo "- collection_market		 : [String], the market collection table name to be used"
	echo "- db_username              : [String], the mongodb user name for authentication"
	echo "- db_password              : [String], the mongodb user password for authentication" 
    echo "- fm_username              : [String], the farmadati user name for authentication"
	echo "- fm_password              : [String], the farmadati user password for authentication" 
    echo "- sourceDirectory          : [String], the source directory of the file to be processed    " 
    echo "- sourcefile               : [String], the source fiel to be processed   "
   	echo "- talendLogDir	         : [String], The directory for Talend Job log"
	echo "Example : ./Create_Market_TR017.sh 94.23.179.228 27017  markets TR017 talendUser ba+Req6@agu6 BDD250591G yqLfFtz9 /data/aggregate/Italy/market/  market.xlsx /var/log/welfinity/talend/WIM/"
	exit
fi

DATABASE_URL=$1
DATABASE_PORT=$2
DATABASE_MARKET=$3
COLLECTION_MARKET=$4
DB_USERNAME=$5
DB_PASSWORD=$6
FM_USERNAME=$7
FM_PASSWORD=$8
SOURCE_DIR=$9
SOURCE_FILE=$10
LOGDIR=$11


echo "$LOG_DATE parameters : DATABASE_URL => $1 DATABASE_PORT => $2 DATABASE_MARKET => $3 COLLECTION_MARKET => $4 DB_USERNAME => $5 DB_PASSWORD => $6 FM_USERNAME => $7 FM_PASSWORD => $8  SOURCE_DIRECTORY => $9 SOURCE_FILE => $10 LOGDIR => $11 "

#Process Data
echo "$LOG_DATE Create Marker TR017"
/opt/welfinity/talend/jobs/WIM/Farmadati_Create_Market_Table_TR017/Farmadati_Create_Market_Table_TR017/Farmadati_Create_Market_Table_TR017_run.sh --context_param database_url=$1 --context_param database_port=$2 --context_param database_market=$3  --context_param collection_market=$4 --context_param db_user=$5 --context_param db_password=$6 --context_param fm_user=$7 --context_param fm_password=$8 --context_param sourceDirectory=$9  --context_param source_file=$10 --context_param logDirectory=$11