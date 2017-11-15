#!/bin/sh
# 
# Welfinity Farmadati Tables Update
# Author : Cristiano Ressi di Cervia , Welfinity
# date : 30/08/2017
# version : 1.0
#
# The aim of this job is to setup the Farmdati table for the first time
# 
# 

#Query Update and Apply - TR001
QUERYDATE=$(date --date="-1 day" +"%d/%m/%y")

./Farmadati_QueryTableUpdate.sh TR001 BDD250591G yqLfFtz9 $QUERYDATE /var/log/welfinity/talend/farmadati/
./FarmadatiApplyUpdateTR001ToMongoDB.sh 217.182.194.167 27017 Product_Dictionaries_Italy TR001 talendUser ba+Req6@agu6  /var/log/welfinity/talend/farmadati/

./Farmadati_QueryTableUpdate.sh TR017 BDD250591G yqLfFtz9 $QUERYDATE /var/log/welfinity/talend/farmadati/
./FarmadatiApplyUpdateTR017ToMongoDB.sh 217.182.194.167 27017 Product_Dictionaries_Italy TR017 talendUser ba+Req6@agu6  /var/log/welfinity/talend/farmadati/

#Clean-up
rm /data/Farmadati/Tables/Update/*.*
rm /data/Farmadati/Tables/*.*