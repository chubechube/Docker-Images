FROM mongo:3.4

#Port
EXPOSE 27017

# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV MONGODB_SCRIPT_DIR /opt/welfinity/mongodb/script

#Scipt and jobs Copy

RUN mkdir -p $MONGODB_SCRIPT_DIR
ADD script_files $MONGODB_SCRIPT_DIR



