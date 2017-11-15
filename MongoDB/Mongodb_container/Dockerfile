FROM mongo:3.2

#Port
EXPOSE 27017
# File Author / Maintainer
LABEL maintainer="Cristiano Ressi Di Cervia"

#Evironment Variable
ENV MONGODB_CONFIG_DIR /opt/welfinity/mongodb/

#Scipt and jobs Copy
RUN mkdir -p $MONGODB_CONFIG_DIR
ADD config $MONGODB_CONFIG_DIR

#use custom config file
USER root
#RUN mongod --fork --logpath /var/log/mongod.log
#RUN mongo ${MONGODB_CONFIG_DIR}/createUser.js

CMD mongod



