#WITTJ Service image
FROM openjdk:8-jre-alpine

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV TALEND_JOB_DIR /opt/welfinity/talend/jobs/WITTJ/
ENV TALEND_SCRIPT_DIR /opt/welfinity/scripts/WITTJ/
ENV TALEND_LOG_DIR /var/log/welfinity/talend/WITTJ/
ENV SCRIPT_LOG_DIR /var/log/welfinity/script/WITTJ/
ENV TEST_DIR /testdata/

USER root

#Add required date utils
RUN apk add --update coreutils && rm -rf /var/cache/apk/*



#Scipt and jobs Copy
RUN mkdir -p $TALEND_JOB_DIR
RUN mkdir -p $TALEND_SCRIPT_DIR
RUN mkdir -p $TALEND_LOG_DIR
RUN mkdir -p $SCRIPT_LOG_DIR
RUN mkdir -p $TEST_DIR

ADD jobs $TALEND_JOB_DIR
ADD scripts $TALEND_SCRIPT_DIR
ADD testData $TEST_DIR

WORKDIR $TALEND_SCRIPT_DIR


