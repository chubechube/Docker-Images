FROM busybox

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV LOGSTASH_CONFIG_DIR   /usr/share/logstash/config/
ENV LOGSTASH_PIPELINE_DIR /usr/share/logstash/pipeline/

USER root


#Scipt and jobs Copy
RUN mkdir -p $LOGSTASH_CONFIG_DIR
RUN mkdir -p $LOGSTASH_PIPELINE_DIR
ADD config $LOGSTASH_CONFIG_DIR
ADD pipeline $LOGSTASH_PIPELINE_DIR

