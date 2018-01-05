FROM docker.elastic.co/kibana/kibana:5.6.2

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV KIBANA_CONFIG_DIR  /usr/share/kibana/config/

USER root


#Scipt and jobs Copy
RUN mkdir -p $KIBANA_CONFIG_DIR
ADD config $KIBANA_CONFIG_DIR

