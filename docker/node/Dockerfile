# Event server
FROM node:20 as event_main
ENV TZ Europe/Moscow
ENV NODE_PATH /home/node/app/node_modules
WORKDIR /home/node/app
COPY ./SmartYard-Server/server/services/event/package*.json /home/node/app
RUN npm i
COPY ./SmartYard-Server/server/services/event .

# Push service
FROM node:20 as push_main
ENV TZ Europe/Moscow
ENV NODE_PATH /home/node/app/node_modules
WORKDIR /home/node/app
COPY ./SmartYard-Server/server/services/push/package*.json /home/node/app
RUN npm i
COPY ./SmartYard-Server/server/services/push/ .
