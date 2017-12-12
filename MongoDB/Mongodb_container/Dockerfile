FROM mongo:3.4

#Port
EXPOSE 27017

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV MONGODB_SCRIPT_DIR /opt/welfinity/mongodb/script
ENV MONGODB_LOG_DIR /var/log/welfinity/log


#Scipt and jobs Copy
RUN mkdir -p $MONGODB_LOG_DIR
RUN mkdir -p $MONGODB_SCRIPT_DIR
ADD script_files $MONGODB_SCRIPT_DIR

WORKDIR $MONGODB_SCRIPT_DIR
CMD "./setup-and-start.sh"


