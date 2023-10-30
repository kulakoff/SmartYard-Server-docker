FROM node:19 as main

WORKDIR /home/node/app

COPY ./SmartYard-Server/server/syslog/package*.json /home/node/app

RUN npm i

COPY ./SmartYard-Server/server/syslog .