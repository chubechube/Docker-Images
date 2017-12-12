#!/bin/sh
# 
# Welfinity Pharmacies List Setup
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 11/12/2017
# version : 1.0
#
# The aim of this job is to setup the pharmacies lists for the first time
# 
# 
#Logging setup

NOW=$(date +"%Y_%m_%d")

FILENAME="$NOW-Load_AllPharmaciesList.log"

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/var/log/welfinity/script/pharmacyload/$FILENAME 2>&1

LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S [FARMADATI_LOADALLPHARMACIESLIST]")

# Creating Log dir
mkdir -p /var/log/welfinity/talend/farmadati/
mkdir -p /var/log/welfinity/script/farmadati/

#Tables dowload from Farmadati SOAP Service 
echo "$LOG_DATE Tables dowload from Farmadati SOAP Service"
/opt/welfinity/talend/scripts/pharmacyload/LoadItalianPharmacies.sh 94.23.179.228 27017 Pharmacies_list italy  talendUser ba+Req6@agu6 /var/log/welfinity/talend/pharmacyload/ http://www.dati.salute.gov.it/imgs/C_17_dataset_5_download_itemDownload0_upFile.CSV
/opt/welfinity/talend/scripts/pharmacyload/LoadBelgianPharmacies.sh 94.23.179.229 27017 Pharmacies_list belgium  talendUser  ba+Req6@agu6 /var/log/welfinity/talend/pharmacyload/ https://www.afmps.be/sites/default/files/content/INSP/OFFICINES/lst_pharmacies_pub_extended_20171114.xlsx