#FILEBEAT for WIM Service
FROM docker.elastic.co/beats/filebeat:5.6.3

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV FILEBEAT_CONFIG_DIR /usr/share/filebeat/



#Scipt and jobs Copy
ADD config $FILEBEAT_CONFIG_DIR

#use custom config file
USER root
RUN chown filebeat /usr/share/filebeat/filebeat.yml
USER filebeat




