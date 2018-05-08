#!/bin/sh
# 
# Welfinity Create All Market Support Tables from MongoDB 
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 12/04/2018
# version : 1.0
#
# The aim of this job is to  create all the market  support tables from a MongodbTable for a specific market 
# 
# 
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Create_ALL_Market_Support_Tables_From_Mongodb.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/WIM/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [WIM_Create_Market_Support_Tables_From_Mongodb]")


# checking parameters before anything
if [ $# != 11 ]; then

    echo "Welfinity Create All Support Tables From MongoDB"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- database_url             : [String], the mongodb address to be used"
	echo "- database_port            : [String], the mongodb port to be used"
	echo "- database_market		     : [String], the mongodb market database to be used".
	echo "- collection_market		 : [String], the market collection table name to be used"
	echo "- db_username              : [String], the mongodb user name for authentication"
	echo "- db_password              : [String], the mongodb user password for authentication" 
	echo "- database_source          : [String], the mongodb source database to be used"
	echo "- collection_source        : [String], the mongodb source collection to be used"
    echo "- market name              : [String], the market name to be used"
    echo "- database_destination     : [String], the database where to create the support tables"
   	echo "- talendLogDir	         : [String], The directory for Talend Job log"
	echo "- createIndex	         	 : [String], Create an Index 0 = no , 1 = yes"
	echo "Example : ./Create_All_Market_Support_Tables_From_MongoDB.sh 94.23.179.229 27017  markets italianmarkets talendUser ba+Req6@agu6   Product_Dictionaries_Italy  TestTabs markets /var/log/welfinity/talend/WIM/  1"
	exit
fi

DATABASE_URL=$1
DATABASE_PORT=$2
DATABASE_MARKET=$3
COLLECTION_MARKET=$4
DB_USERNAME=$5
DB_PASSWORD=$6
DATABASE_SOURCE=$7

MARKET_NAME=$8
DATABASE_DESTINATION=$9

LOGDIR=$10

CREATE_INDEX=$11


echo "$LOG_DATE parameters : DATABASE_URL => $1 DATABASE_PORT => $2 DATABASE_MARKET => $3 COLLECTION_MARKET => $4 DB_USERNAME => $5 DB_PASSWORD => $6 DATABASE_SOURCE => $7 MARKET_NAME => $8 DATABASE_DESTINATION=>$9  LOGDIR => $10  CREATE_INDEX = $11"

#Process Data
echo "$LOG_DATE Start Create Market Support Tables From MongoDB"

echo "$LOG_DATE Start Creation of table TR001"
COLLECTION_SOURCE=TR001
INDEX_KEY=FDI_0001
QUERY_KEY=FDI_0001
UNIQUE_INDEX=1
/opt/welfinity/talend/jobs/WIM/Create_Market_Support_Table_From_MongoDB/Create_Market_Support_Table_From_MongoDB/Create_Market_Support_Table_From_MongoDB_run.sh --context_param database_url=$1 --context_param database_port=$2 --context_param database_market=$3  --context_param collection_market=$4 --context_param db_user=$5 --context_param db_password=$6  --context_param database_source=$7  --context_param collection_source=$COLLECTION_SOURCE --context_param marketName=$8 --context_param database_destination=$9 --context_param querykey=$QUERY_KEY --context_param logDirectory=$10 --context_param indexKey=$INDEX_KEY --context_param uniqueIndes=$UNIQUE_INDEX --context_param createIndex=$11
echo "$LOG_DATE END Creation of table TR001"

echo "$LOG_DATE Start Creation of table TR017"
COLLECTION_SOURCE=TR017
INDEX_KEY=FDI_T139
QUERY_KEY=FDI_T139
UNIQUE_INDEX=1
/opt/welfinity/talend/jobs/WIM/Create_Market_Support_Table_From_MongoDB/Create_Market_Support_Table_From_MongoDB/Create_Market_Support_Table_From_MongoDB_run.sh --context_param database_url=$1 --context_param database_port=$2 --context_param database_market=$3  --context_param collection_market=$4 --context_param db_user=$5 --context_param db_password=$6  --context_param database_source=$7  --context_param collection_source=$COLLECTION_SOURCE --context_param marketName=$8 --context_param database_destination=$9 --context_param querykey=$QUERY_KEY --context_param logDirectory=$10 --context_param indexKey=$INDEX_KEY --context_param uniqueIndes=$UNIQUE_INDEX --context_param createIndex=$11
echo "$LOG_DATE END Creation of table TR017"

echo "$LOG_DATE End Create Market Support Tables From MongoDB"