#!/bin/sh
# 
# Welfinity Data Aggregation for Italy
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 11/12/2017
# version : 1.0
#
# The aim of this job is to  aggregate data for Italy
# 
# 
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Extract_and_Aggregate_Italy.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/WDM/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [WDM_EXTRACT_AND_AGGREGATION_ITALY]")


# checking parameters before anything
if [ $# != 22 ]; then
	echo "Welfinity Aggregation"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
    echo "- database_url             : [String], the mongodb address to be used"
	echo "- database_port            : [String], the mongodb port to be user"
	echo "- username                 : [String], the mongodb user name for authentication"
	echo "- password                 : [String], the mongodb user password for authentication" 
    echo "- database_pharmacies      : [String], the mongodb database to be used".
	echo "- collection_pharmacies    : [String], the pharmacy collection table name to be used"
    echo "- database_products        : [String], the database with the production table extract"
    echo "- database_farmadati       : [String], the farmadati database   "
    echo "- sourceDirectory          : [String], the source directory of the file to be processed    " 
    echo "- destDirectory            : [String], the destination directory of the  processed file   "
    echo "- sourcefile               : [String], the source file to be processed   "
    echo "- destFile                 : [String], the destination file of the processed file    "
	echo "- talendLogDir	         : [String], The directory for Talend Job log"

	echo "- document	             : [String], as of replica's document. It refers to the definition of a import, and also to an index in Elastic Search"
	echo "- filterField              : [String], the field on which a filter will be applied"
	echo "- filterValue              : [String], the string value that will be used to filter. Note that if the string contains a comma, then the filter will act as 'true if field contains one of the filter values'".
	echo "- dateField            	 : [String], the field on which date comparison can be made"
	echo "- periodStart              : [String], a date, with format dd/MM/yyyy, i.e. '12/09/2011'"
	echo "- periodEnd 	             : [String], a date, with format dd/MM/yyyy, i.e. '09/08/2009'"
	echo "- wimDest 	             : [String], a destination folder, with format username@host:directory  'ressic@94.23.179.229:/data'"
	echo "- nodi_host 	             : [String], the nodi replica host address i.e 94.23.179.225 "
	echo "- nodi_user 	             : [String], the nodi user i.e  nodiuser "
	echo "Example : ./Extract_and_Aggregate_Italy.sh 94.23.179.228 27017 talendUser ba+Req6@agu6 Pharmacies_list Italy markets Product_Dictionaries_Italy /data/aggregate/Italy/toAggregate/ /data/aggregate/Italy/Aggregated/ filetoaggregate.csv aggregated.xls /var/log/welfinity/talend/WDM/  italy_prp Product_ID '027546023,025369048,908924412' Transaction_Timestamp 01/01/2015 31/12/2017 'ressic@94.23.179.228:/data/Italy/toAggregate' 94.23.179.225 nodiuser"
	exit
fi



DATABASE_URL=$1
DATABASE_PORT=$2
USERNAME=$3
PASSWORD=$4
DATABASE_PHARMACIES=$5
COLLECTION_PHARMACIES=$6
DATABASE_PRODUCTS=$7
DATABASE_FARMADATI=$8
SOURCE_DIR=$9
DEST_DIR=$10
SOURCE_FILE=$11
DEST_FILE=$12
LOGDIR=$13
DOCUMENT=$14
FILTER_FIELD=$15
FILTER_VALUE=$16
DATE_FIELD=$17
PERIOD_START=$18
PERIOD_END=$19
WIM_DEST=$20
NODI_HOST=$21
NODI_USER=$22


echo "parameters : "

echo "DOCUMENT : $DOCUMENT => $14"
echo "FILTER_FIELD : $FILTER_FIELD => $15"
echo "FILTER_VALUE : $FILTER_VALUE => $16"
echo "DATE_FIELD : $DATE_FIELD => $17"
echo "PERIOD_START : $PERIOD_START => $18"
echo "PERIOD_END : $PERIOD_END => $19"
echo "WIM_DEST : $WIM_DEST => $20"
echo "NODI_HOST : $NODI_HOST => $21"
echo "NODI_USER : $NODI_USER => $22"

echo "$LOG_DATE parameters : DATABASE_URL => $1 DATABASE_PORT => $2 USERNAME => $3 PASSWORD => $4  DATABASE_PHARMACIES => $5 COLLECTION_PHARMACIES => $6 DATABASE_PRODUCTS => $7 DATABASE_FARMADATI => $8 SOURCE_DIRECTORY => $9 DEST_DIRECTORY => $10 SOURCE_FILE => $11 DEST_FILE => $12  $LOGDIR => $13 "


echo "Extracting Data => $DOCUMENT  $FILTER_FIELD $FILTER_VALUE  $DATE_FIELD $PERIOD_START $PERIOD_END $WIM_DEST $NODI_HOST $NODI_USER "
./Extract_Data.sh $DOCUMENT  $FILTER_FIELD $FILTER_VALUE  $DATE_FIELD $PERIOD_START $PERIOD_END $WIM_DEST $NODI_HOST $NODI_USER
echo "Data Extracted"


echo "Aggragating Data => $DATABASE_URL $DATABASE_PORT $USERNAME $PASSWORD $DATABASE_PHARMACIES $COLLECTION_PHARMACIES $DATABASE_PRODUCTS $DATABASE_FARMADATI $SOURCE_DIR $DEST_DIR $SOURCE_FILE $DEST_FILE $LOGDIR "
./Aggregation_Italy.sh $DATABASE_URL $DATABASE_PORT $USERNAME $PASSWORD $DATABASE_PHARMACIES $COLLECTION_PHARMACIES $DATABASE_PRODUCTS $DATABASE_FARMADATI $SOURCE_DIR $DEST_DIR $SOURCE_FILE $DEST_FILE $LOGDIR
echo "Data Aggregated"