 #!/usr/bin/env bash
shopt -s extglob
if [ $# -ne 5 ]; then
	echo "Welfinity DeployStackScript "
	echo "----------------------------------"
	echo "Error : Wrong number of parameters"
	echo "The script must have the following parameters : "
	echo "- source dir               : [String], the stack template  dir"
	echo "- dest dir                 : [String], the stack temporary working dir"
    echo "- stack name               : [String], the stack name to be used working dir"
    echo "- environment              : [String], the environment to be used"
    echo "- deploy                   : [String], 0 deploy the stak , 1 don't deploy the stack ,2 just update the images"
	echo "Example : ./deployStackScript ./WIM ./tmpWIM wim-service"
	exit
fi


    SOURCE_DIR=$1
    
    STACK_NAME=$3
    ENV_TYPE=$4
    PUSH=$5
   # DEPLOYSCRIPTDIR="$(dirname $(readlink -f $0))"
    DEPLOYSCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)"
    TEMP_DEST_DIR=$DEPLOYSCRIPTDIR/$2
    EXCLUDE_FILE="welfinity-exclude.txt"


    
    echo "----> $0 <---"
    echo "SOURCE_DIR    =   $1"
    echo "TEMP_DEST_DIR =   $TEMP_DEST_DIR"
    echo "STACK_NAME    =   $3"
    echo "DEPLOYDIR     =   $DEPLOYSCRIPTDIR"
    echo "ENV_TYPE      =   $4"
    echo "PUSH          =   $5"


#cd source dir and copy all the files to the target directory

blackonwhit='\e[04;30;47m' 
redonwhit='\e[04;31;47m'
whiteonblue='\e[0;37;44m'
endColor='\e[0m'


echo -e " ${blackonwhit}  Deploy $3  in ${redonwhit} $4 ${endColor} "

cd $SOURCE_DIR
mkdir $TEMP_DEST_DIR

if [ -f "$EXCLUDE_FILE" ]
then
    rsync -a --progress ./ $TEMP_DEST_DIR --exclude-from $EXCLUDE_FILE
else
	rsync -a --progress ./ $TEMP_DEST_DIR 
fi


#Cd to the temp dir and config variable import
cd $TEMP_DEST_DIR

#Check config file for malicious code
configfile='deploy.config.'$ENV_TYPE
echo "USING CONFIG FILE deploy.config.$ENV_TYPE" 
if [ -f ${configfile} ]; then
    echo "Reading user config...." >&2

    # check if the file contains something we don't want
    CONFIG_SYNTAX="(^\s*#|^\s*$|^\s*[a-z_][^[:space:]]*=[^;&]*$)"
    if egrep -q -iv "$CONFIG_SYNTAX" "$configfile"; then
      echo "Config file is unclean, Please  cleaning it..." >&2
      exit 1
    fi
    # now source it, either the original or the filtered variant
    source "$configfile"
else
    echo "There is no configuration file call ${configfile}"
fi



#replace values in template files
echo -e "${whiteonblue} Configuring Rise script  ${endColor} "
. $DEPLOYSCRIPTDIR/configureRiseScriptScript.sh $RANCHER_URL $RANCHER_ACCESS_KEY $RANCHER_SECRET_KEY $RANCHER_ENVIRONMENT $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor} \n  "

echo -e "${whiteonblue} Configuring ELK Stack  ${endColor} "
$DEPLOYSCRIPTDIR/configureELKstack.sh $ELK_STACK $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor} \n "

echo -e "${whiteonblue} Configuring MongoDB  ${endColor} "
$DEPLOYSCRIPTDIR/configureMongoDb.sh $MONGODB_ADDRESS $MONGODB_PORT $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor}  \n "


#create live files from template files
echo -e "${whiteonblue} Generating file from templates  ${endColor} "
$DEPLOYSCRIPTDIR/renametemplatefiles.sh $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor} \n  "

#Now setting all permissions
echo -e "${whiteonblue} Setting file permissions  ${endColor} "
$DEPLOYSCRIPTDIR/configureScriptPermission.sh $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor}  \n  "

if [ "$5" == "0" ]
then

#build and push images
echo -e "${whiteonblue} Building and Pushing Images  ${endColor} "
$DEPLOYSCRIPTDIR/buildandpushImage.sh $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor} \n  "


#run rancher-compose 
echo -e "${whiteonblue} Deploy stack using rancher  ${endColor} "
chmod 755 riseScript.sh
./riseScript.sh $STACK_NAME
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor} \n  "

#clean up
echo -e "${whiteonblue} CLean up  ${endColor} "
rm -rf $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor}  \n "
fi

if [ "$5" == "2" ]
then

#build and push images
echo -e "${whiteonblue} Building and Pushing Images  ${endColor} "
$DEPLOYSCRIPTDIR/buildandpushImage.sh $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor} \n  "


#clean up
echo -e "${whiteonblue} CLean up  ${endColor} "
rm -rf $TEMP_DEST_DIR
echo -e "${whiteonblue} ---------------------------------------------------------------  ${endColor}  \n "
fi