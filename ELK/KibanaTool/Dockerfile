FROM alpine:3.5

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"



#Evironment Variable
ENV KIBANA_DIR /opt/welfinity/Kibana


USER root

#Add required date utils
RUN apk --update add bash nodejs && rm -rf /var/cache/apk/*
RUN npm install -g elasticdump && rm -rf /var/cache/apk/*


#Scipt and jobs Copy
RUN mkdir -p $KIBANA_DIR

ADD DashboardAndVisualization $KIBANA_DIR

#ENTRYPOINT ["/usr/bin/elasticdump"]

