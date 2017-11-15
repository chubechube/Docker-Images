FROM mongo:3.4


# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV MONGODB_SCRIPT_DIR /opt/welfinity/mongodb/script
ENV SUPPORT_SCRIPT_DIR /opt/welfinity/support

#Scipt and jobs Copy
RUN mkdir -p $MONGODB_SCRIPT_DIR
ADD script_files $MONGODB_SCRIPT_DIR
RUN mkdir -p $SUPPORT_SCRIPT_DIR
ADD support_files $SUPPORT_SCRIPT_DIR

#use custom config file
USER root

CMD bash



