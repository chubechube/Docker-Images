#!/bin/sh
# 
# Welfinity Load Italian pharmacies from MOH list
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 30/08/2017
# version : 1.0
#
# The aim of this job is to load the Belgian Pharmacies list into Welfinity MongoDb
# 
# 
# Parameters
# ---------------
# database_url		mongodb uri             				- default value :   217.182.194.167
# database_port		mongodb port           					- default value :	27017
# database	        mongodb database       					- default value :	Product_Dictionaries_Italy
# collection	    mongodb collection      				- default value :	TR001
# user	            mongodb user name       				- default value :	talendUser
# password	    	mongodb user password   				- default value :	ba+Req6@agu6
# TalendLogDir	 The directory for Talend Job log

#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-LoadBelgianPharmacies.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/pharmacyload/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [Load_Italian_Pharmacies]")
# checking parameters before anything
if [ $# != 8 ]; then
	echo "Welfinity LoadFBelgianPharmacies Job"
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- database_url    : [String], the mongodb address to be used"
	echo "- database_port   : [String], the mongodb port to be user"
	echo "- database        : [String], the mongodb database to be used".
	echo "- collection      : [String], the mongodb collection to be used"
	echo "- user            : [String], the mongodb user name for authentication"
	echo "- password        : [String], the mongodb user password for authentication"
	echo "- talendLogDir	: [String], The directory for Talend Job log"
	echo "- list_url	 	: [String], The URL from were dowload the list"
	echo "Example : ./LoadBelgianPharmacies.sh '94.23.179.229' 27017 Pharmacies_list belgium  talendUser 'ba+Req6@agu6' '/var/log/welfinity/talend/pharmacyload/' https://www.afmps.be/sites/default/files/content/INSP/OFFICINES/lst_pharmacies_pub_extended_20171114.xlsx"
	exit
fi

URI=$1
PORT=$2
DATABASE=$3
COLLECTION=$4
USER=$5
PASSWORD=$6
LOGDIR=$7
LISTURL=$8

echo "$LOG_DATE parameters : URI : $URI => $1 PORT : $PORT => $2 DATABASE : $DATABASE => $3 COLLECTION : $COLLECTION => $4 USER : $USER => $5 PASSWORD : $PASSWORD => $6 LOGDIR : $LOGDIR => $7 $LISTURL=>$8"

# call the talend job over the new file
echo "$LOG_DATE Talend Job Starting"
/opt/welfinity/talend/jobs/pharmacyload/LoadBelgianPharmacyListToMongoDb/LoadBelgianPharmacyListToMongoDb/LoadBelgianPharmacyListToMongoDb_run.sh --context_param database_url=$1 --context_param database_port=$2 --context_param database=$3 --context_param collection=$4 --context_param user=$5 --context_param password=$6 --context_param logDirectory=$7 --list_uri=$8
echo "$LOG_DATE Talend Job Finished"

echo "$LOG_DATE Index Creation"
mongo 
exit
