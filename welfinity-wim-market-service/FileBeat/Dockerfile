#FILEBEAT for WIM Service
FROM docker.elastic.co/beats/filebeat:6.2.4

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




