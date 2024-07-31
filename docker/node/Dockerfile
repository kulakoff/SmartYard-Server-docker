# syslog server legacy version
FROM node:20.16.0 as event_legacy
ENV TZ Europe/Moscow
ENV NODE_PATH /home/node/app/node_modules
WORKDIR /home/node/app
COPY ./SmartYard-Server/server/services/syslog/package*.json /home/node/app
RUN npm i
COPY ./SmartYard-Server/server/services/syslog .

# event server
FROM node:20.16.0 as event_main
ENV TZ Europe/Moscow
ENV NODE_PATH /home/node/app/node_modules
WORKDIR /home/node/app
COPY ./SmartYard-Server/server/services/event/package*.json /home/node/app
RUN npm i
COPY ./SmartYard-Server/server/services/event .