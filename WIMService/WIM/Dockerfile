FROM openjdk:8-jre-alpine

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV TALEND_JOB_DIR /opt/welfinity/talend/jobs/WIM/
ENV TALEND_SCRIPT_DIR /opt/welfinity/talend/scripts/WIM/

USER root

#Add required utils
RUN apk add --update coreutils && rm -rf /var/cache/apk/*

#Scipt and jobs Copy
RUN mkdir -p $TALEND_JOB_DIR
RUN mkdir -p $TALEND_SCRIPT_DIR

ADD jobs $TALEND_JOB_DIR
ADD scripts $TALEND_SCRIPT_DIR


WORKDIR $TALEND_SCRIPT_DIR



