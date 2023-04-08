FROM node:18 as main

WORKDIR /home/node/app

COPY ./rbt/server/syslog/package*.json /home/node/app

RUN npm i

COPY ./rbt/server/syslog .