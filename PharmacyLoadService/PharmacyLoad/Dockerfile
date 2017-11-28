FROM openjdk:8-jre-alpine

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV TALEND_JOB_DIR /opt/welfinity/talend/jobs/pharmacyload/
ENV TALEND_SCRIPT_DIR /opt/welfinity/talend/scripts/pharmacyload/
ENV TALEND_LOG_DIR /var/log/welfinity/talend/pharmacyload/
ENV SCRIPT_LOG_DIR /var/log/welfinity/script/pharmacyload/
ENV PHARMACY_LISTS_DIR /data/PharmaciesLists/

USER root

#Add required utils
RUN apk add --update coreutils && rm -rf /var/cache/apk/*

#Scipt and jobs Copy
RUN mkdir -p $TALEND_JOB_DIR
RUN mkdir -p $TALEND_SCRIPT_DIR
RUN mkdir -p $TALEND_LOG_DIR
RUN mkdir -p $SCRIPT_LOG_DIR
RUN mkdir -p $PHARMACY_LISTS_DIR

ADD jobs $TALEND_JOB_DIR
ADD scripts $TALEND_SCRIPT_DIR
ADD lists $PHARMACY_LISTS_DIR

WORKDIR $TALEND_SCRIPT_DIR



