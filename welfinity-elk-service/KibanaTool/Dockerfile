FROM alpine:3.5

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"



#Evironment Variable
ENV KIBANA_DIR /opt/welfinity/Kibana


USER root

#Add required date utils
RUN apk --update add bash nodejs && rm -rf /var/cache/apk/*



#Scipt and jobs Copy
RUN mkdir -p $KIBANA_DIR
RUN cd $KIBANA_DIR
RUN npm install -g elasticdump && rm -rf /var/cache/apk/*
RUN npm install  elasticsearch && rm -rf /var/cache/apk/*

ADD DashboardAndVisualization $KIBANA_DIR
ADD Maintenance $KIBANA_DIR

WORKDIR $KIBANA_DIR

#ADD CronJob
RUN echo '00 20 * * * /opt/welfinity/Kibana/deletedocuments.sh' > /etc/crontabs/root
#ENTRYPOINT ["/usr/bin/elasticdump"]

