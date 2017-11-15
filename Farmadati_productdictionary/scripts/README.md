# Farmadati Scripts

This project aims at developping a set of bash scripts that will retrieve data from the Farmdati Product Dictionary service and upload it into the Welfinity Private Cloud

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

The scripts are used to run Talend jobs that connects, retrieve, manipulate and uploade the data.


### Prerequisites

You'll need a linux OS machine (bash script power).
You'll need to have "curl" installed on your machine.
You'll need to have "unzip" installed on your machine.
And that's all =)

### Installing

First you have to define the talend scripts  folder that is by default:

/opt/welfinity/scripts/farmadati/

, as root, create the following :

```
mkdir /opt/welfinity/scripts/farmadati/
```


You can find the talend scripts on Welfinity bitbucket here :

https://agora.groupe.pharmagest.com/bitbucket/projects/WELF/repos/farmadatilinuxscripts/browse

```
mkdir -p /opt/welfinity/talend/jobs/farmadati
cp MY_JOB /opt/welfinity/talend/jobs/farmadati
```

Finally, you'll deploy the script on your machine, using git. Create folders /opt/welfinity/scripts/farmadati and set yourself into the last one.

```
mkdir -p /opt/welfinity/scripts/farmadati
cd /opt/welfinity/scripts/farmadati
```

Use git to checkout the develop branch.

```
git clone https://USERNAME@agora.groupe.pharmagest.com/bitbucket/scm/welf/farmadatilinuxscripts.git
git checkout develop
```

And finally give execution rights to the file.

```
chmod 755 ./SCRIPTTOBEEXECUTED
```

## Running the tests

Simply execute the script to have it running.
`

## Deployment

For production, always use the master branch.

```
git checkout master
```

You can define a cron job to have it working automatically.

## Scripts Index and description

* Farmadati_GetDataSet_GetRecords_Table_Input.sh
```
The aim of this script is to download a specific table from Farmdati SOAP Service. 

This script need the follwing Talend Job to be run : Farmadati_Farmadati_GetDataSet_GetRecords_Table_Input.sh
 
 Parameters
 ---------------

 - table            A Farmadati Table Identifier
 - username         The Farmadati user username
 - password         The Farmadati user password 
 - talendLogDir	 The directory for Talend Job log
 ```

* LoadFarmadatiTableTS010ToMongoDB.sh
```
 The aim of this script is to upload Farmadati Table TS010 to MongoDB instance in the welfinity private cloud

 This script need the following Talend Job to be run : Farmadati_TS010.sh

 Parameters
 ---------------
 - database_url		mongodb uri
 - database_port	mongodb port
 - database	        mongodb database 
 - collection	    mongodb collection
 - user             mongodb user name
 - password	    	mongodb user password
 - talendLogDir	 The directory for Talend Job log
```

* LoadFarmadatiTableTR001ToMongoDB
```
The aim of this script is to upload Farmadati Table TR001 to MongoDB instance in the welfinity private cloud

This script need the following Talend Job to be run : Farmadati_TR001.sh


Parameters
 ---------------
 - database_url		mongodb uri
 - database_port    mongodb port
 - database	        mongodb database 
 - collection	    mongodb collection
 - user             mongodb user name
 - password	    	mongodb user password
 - talendLogDir	 The directory for Talend Job log
```

* LoadFarmadatiTableTR017ToMongoDB
```
The aim of this script is to upload Farmadati Table TR017 to MongoDB instance in the welfinity private cloud

This script need the following Talend Job to be run : Farmadati_TR017.sh


Parameters
 ---------------
 - database_url		    mongodb uri
 - database_port		mongodb port
 - database	            mongodb database 
 - collection	        mongodb collection
 - user                 mongodb user name
 - password	    	    mongodb user password
 - talendLogDir	        The directory for Talend Job log
```

* LoadFarmadatiTableTR019ToMongoDB
```
The aim of this script is to upload Farmadati Table TR019 to MongoDB instance in the welfinity private cloud

This script need the following Talend Job to be run : Farmadati_TR019.sh


Parameters
 ---------------
 - database_url		    mongodb uri
 - database_port		mongodb port
 - database	            mongodb database 
 - collection	        mongodb collection
 - user                 mongodb user name
 - password	    	    mongodb user password
 - talendLogDir	        The directory for Talend Job log
```

* LoadFarmadatiTableTR026ToMongoDB
```
The aim of this script is to upload Farmadati Table TR026 to MongoDB instance in the welfinity private cloud

This script need the following Talend Job to be run : Farmadati_TR026.sh


Parameters
 ---------------
 - database_url		    mongodb uri
 - database_port		mongodb port
 - database	            mongodb database 
 - collection	        mongodb collection
 - user                 mongodb user name
 - password	    	    mongodb user password
 - talendLogDir	        The directory for Talend Job log
```

* Farmadati_QueryUpdateTable
```
The aim of this script is is to query the update for a Table and save it into the welfinity private cloud

 Parameters
 ---------------
 - table   	          farmadati table identifier       
 - user               farmadati user name               
 - password	    	  farmadati user password           
 - lastUpdateDate     the date of the last update
 - talendLogDir	  The directory for Talend Job log    
```

* Farmadati_ApplyTableChanges_TR001
```
The aim of this script is to appy the changes to the  Farmadati Table TR001 into the MongoDB collection instance in the welfinity private cloud

This script need the following Talend Job to be run : Farmadati_ApplyTableChanges_TR001_run.sh


Parameters
 ---------------
 - database_url		    mongodb uri
 - database_port		mongodb port
 - database	            mongodb database 
 - collection	        mongodb collection
 - user                 mongodb user name
 - password	    	    mongodb user password
 - talendLogDir	        The directory for Talend Job log
```

* Farmadati_ApplyTableChanges_TR017
```
The aim of this script is to appy the changes to the  Farmadati Table TR017 into the MongoDB collection instance in the welfinity private cloud

This script need the following Talend Job to be run : Farmadati_ApplyTableChanges_TR017_run.sh


Parameters
 ---------------
 - database_url		    mongodb uri
 - database_port		mongodb port
 - database	            mongodb database 
 - collection	        mongodb collection
 - user                 mongodb user name
 - password	    	    mongodb user password
 - talendLogDir	        The directory for Talend Job log
```

* FistDownload.sh
```
The aim of this script is to load all the tables from Farmadati and store it into the MongoDB collection instance in the welfinity private cloud

* UpdateAllTables.sh
```
The aim of this script is to update all the tables from Farmadati and store it into the MongoDB collection instance in the welfinity private cloud


## Authors

* **Cristiano Ressi di Cervia** - *Initial work* - [Welfinity](http://www.welfinitygroup.com/)

## License

This project fully belongs to Welfinity.
