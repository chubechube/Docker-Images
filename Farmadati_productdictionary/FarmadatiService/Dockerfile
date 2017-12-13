#Welfinity Farmadati Service
FROM openjdk:8-jre-alpine

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV TALEND_JOB_DIR /opt/welfinity/talend/jobs/farmadati/
ENV TALEND_SCRIPT_DIR /opt/welfinity/talend/scripts/farmadati/
ENV TABLE_DIR /data/Farmadati/Tables/
ENV TALEND_LOG_DIR /var/log/welfinity/talend/farmadati/
ENV SCRIPT_LOG_DIR /var/log/welfinity/script/farmadati/

USER root

#Add required utils
RUN apk add --update coreutils && rm -rf /var/cache/apk/*

#Scipt and jobs Copy
RUN mkdir -p $TALEND_JOB_DIR
RUN mkdir -p $TALEND_SCRIPT_DIR
RUN mkdir -p $TABLE_DIR
RUN mkdir -p $TALEND_LOG_DIR
RUN mkdir -p $SCRIPT_LOG_DIR

ADD jobs $TALEND_JOB_DIR
ADD scripts $TALEND_SCRIPT_DIR

WORKDIR $TALEND_SCRIPT_DIR


RUN echo '30 08 * * *  /opt/welfinity/talend/scripts/farmadati/Farmadati_LoadAllTables.sh' > /etc/crontabs/root

CMD crond -l 2 -f

