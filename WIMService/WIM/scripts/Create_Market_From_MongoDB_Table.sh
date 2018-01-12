#!/bin/sh
# 
# Welfinity Create Market from MongoDB Table
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 11/12/2017
# version : 1.0
#
# The aim of this job is to  create a market table from a MongodbTable  
# 
# 
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Create_Market_TR001.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/WIM/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [WIM_Create_Market_TR001]")


# checking parameters before anything
if [ $# != 15 ]; then

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
    echo "- sourceDirectory          : [String], the source directory of the file to be processed    " 
    echo "- sourcefile               : [String], the source fiel to be processed   "
	echo "- database_source          : [String], the mongodb source database to be used"
	echo "- collection_source        : [String], the mongodb source collection to be used"
	echo "- querykey                 : [String], the key to be used for query"
   	echo "- talendLogDir	         : [String], The directory for Talend Job log"
	echo "- indexKey	           	 : [String], The index key to be used if an index is required"
	echo "- uniqueIndex	    		 : [String], The index is unique 0 = no,  1 = yes"
	echo "- createIndex	         	 : [String], Create an Index 0 = no , 1 = yes"
	echo "Example : ./Create_Market_From_MongoDB_Table.sh 94.23.179.229 27017  markets TR017 talendUser ba+Req6@agu6  /data/aggregate/Italy/market/  market.xlsx  Product_Dictionaries_Italy TR017 FDI_T139 /var/log/welfinity/talend/WIM/ FDI_T139 1 1"
	exit
fi

DATABASE_URL=$1
DATABASE_PORT=$2
DATABASE_MARKET=$3
COLLECTION_MARKET=$4
DB_USERNAME=$5
DB_PASSWORD=$6
SOURCE_DIR=$7
SOURCE_FILE=$8
DB_SOURCE=$9
COLLECTION_SOURCE=$10
QUERY_KEY=$11
LOGDIR=$12
INDEX_KEY=$13
UNIQUE_INDEX=$14
CREATE_INDEX=$15


echo "$LOG_DATE parameters : DATABASE_URL => $1 DATABASE_PORT => $2 DATABASE_MARKET => $3 COLLECTION_MARKET => $4 DB_USERNAME => $5 DB_PASSWORD => $6 SOURCE_DIRECTORY => $7 SOURCE_FILE => $8 DB_SOURCE => $9 	COLLECTION_SOURCE=>$10  QUERY_KEY=$11 LOGDIR => $12 UNIQUE_INDEX => $14 CREATE_INDEX = $15"

#Process Data
echo "$LOG_DATE Start Create Market From MongoD Table"
/opt/welfinity/talend/jobs/WIM/Create_Market_Table_From_MongoDB/Create_Market_Table_From_MongoDB/Create_Market_Table_From_MongoDB_run.sh --context_param database_url=$1 --context_param database_port=$2 --context_param database_market=$3  --context_param collection_market=$4 --context_param db_user=$5 --context_param db_password=$6  --context_param sourceDirectory=$7  --context_param source_file=$8 --context_param database_source=$9 --context_param collection_source=$10 --context_param querykey=$11	--context_param logDirectory=$12 --context_param indexKey=$13 --context_param uniqueIndes=$14 --context_param createIndex=$15
echo "$LOG_DATE End Create Market From MongoD Table"