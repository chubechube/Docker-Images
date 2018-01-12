#!/bin/sh
# 
# Welfinity Export and Aggregate Job
# Author : Cristiano Ressi di Cervia
# date : 10/01/2018
# version : 1.0
#
# The aim of this job is to export data from Replica's Elastic Search and copy it to a shared forlder at Welfinity aggregation service WIM
#, so it can be used in Qlik Sense or any other
# reporting tool.
# 
# Parameters
# ---------------
# this script will accept a few parameters
# - rule, as of replica's rule. It refers to the definition of a import, and also to an index in Elastic Search
# - filterField, the field on which a filter will be applied
# - filterValue, the string value that will be used to filter. Note that if the string contains a comma, 
#   then the filter will act as "true if field contains one of the filter values".
# - dateField, the field on which date comparison can be made
# - periodStart, a date, with format dd/MM/yyyy, i.e. 12/09/2011
# - periodEnd, a date, with format dd/MM/yyyy, i.e. 09/08/2009
# - wimDest , the WIM service  destination folder
# - nodi_host 	, the nodi replica host address i.e 94.23.179.225
# - nodi_user 	, the nodi user i.e  nodiuser
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Extract_Data.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/WDM/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [WDM_EXTRACTION_ITALY]")

# checking parameters before anything
if [ $# != 9 ]; then
	echo "Welfinity Export Job"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- rule 		: [String], as of replica's rule. It refers to the definition of a import, and also to an index in Elastic Search"
	echo "- filterField : [String], the field on which a filter will be applied"
	echo "- filterValue : [String], the string value that will be used to filter. Note that if the string contains a comma, then the filter will act as 'true if field contains one of the filter values'".
	echo "- dateField 	: [String], the field on which date comparison can be made"
	echo "- periodStart : [String], a date, with format dd/MM/yyyy, i.e. '12/09/2011'"
	echo "- periodEnd 	: [String], a date, with format dd/MM/yyyy, i.e. '09/08/2009'"
	echo "- wimDest 	: [String], a destination folder, with format username@host:directory  'ressic@94.23.179.229:/data'"
	echo "- nodi_host 	: [String], the nodi replica host address i.e 94.23.179.225 "
	echo "- nodi_user 	: [String], the nodi user i.e  nodiuser "
	echo "Example 		: ./Extract_Data.sh csf productID 31111026,25369048,12745220 transactionTimestamp 09/08/2009 12/09/2011 ressic@94.23.179.229:/data/Italy/toAggregate 94.23.179.225 nodiuser"
	exit
fi

RULE=$1
FILTER_FIELD=$2
FILTER_VALUE=$3
DATE_FIELD=$4
PERIOD_START=$5
PERIOD_END=$6
WIM_DEST=$7
NODI_HOST=$8
NODI_USER=$9


echo "parameters : "
echo "RULE : $RULE => $1"
echo "FILTER_FIELD : $FILTER_FIELD => $2"
echo "FILTER_VALUE : $FILTER_VALUE => $3"
echo "DATE_FIELD : $DATE_FIELD => $4"
echo "PERIOD_START : $PERIOD_START => $5"
echo "PERIOD_END : $PERIOD_END => $6"
echo "WIM_DEST : $WIM_DEST => $7"
echo "NODI_HOST : $NODI_HOST => $8"
echo "NODI_USER : $NODI_USER => $9"


#connection to nodi host and perfom extraction
ssh -tt $NODI_USER@$NODI_HOST << EOF
echo Abcd.1234 | sudo -S /opt/welfinity/scripts/weaj/weaj-crc.sh $RULE  $FILTER_FIELD $FILTER_VALUE  $DATE_FIELD $PERIOD_START $PERIOD_END $WIM_DEST 
exit
EOF
exit
