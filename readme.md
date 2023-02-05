TODO:

1. Copy enviroments
   ````
   cp .example.env .env
   ````
2. Make ssl for NGINX and copy to dir ./docker/nginx/certs:
   ````
   ./docker/nginx/conf.d/certs/nginx.key
   ./docker/nginx/conf.d/certs/nginx.crt
   ````
3. Clone RBT repo:
   ````
   git clone git@github.com:rosteleset/rbt.git
   ````
4. Config RBT, read the docs:  
   https://github.com/rosteleset/rbt/blob/main/install/03.install.md
   
5. Init clickhouse tables  
   https://github.com/rosteleset/rbt/blob/main/install

6. Check config Asterisk  for start in docker container.  
   Example by host in .env
   ###### /rbt/asterisk/http
   ````
   [general]
   enabled = yes
   bindaddr = 172.28.0.1
   bindport = 8088
   tlsenable = no    
   ````
   ###### /rbt/asterisk/config.lua
   ````
   realm = "rbt"
   dm_server = "http://172.28.0.2/asterisk/extensions"
   redis_server_host = "172.28.0.4"
   redis_server_port = 6379
   redis_server_auth = "redis_example_passwd"
   log.outfile = false
   trunk = "first"
   lang = "ru"
   ````
   ###### /rbt/asterisk/extconfig.conf
   ````
   [settings]
   ps_aors = curl,http://172.28.0.2/asterisk/aors
   ps_auths = curl,http://172.28.0.2/asterisk/auths
   ps_endpoints = curl,http://172.28.0.2/asterisk/endpoints

   ````
7. Docker
   Start docker containers:
   ````
   make up
   ````  
   Stop containers:
   ````
   make down
   ````

8. Syslog ?

cd ./rbt/server/syslog
cp config.sample.json config.json

modify config file

npm i
npm run start
____
### RBT CLI
#### Autoconfig intercom 
 ###### First time config
   ``````
   docker exec -it rbt_app php server/cli.php --autoconfigure-domophone=3 --first-time
   ``````
###### Config intercom, config update (added keys or flats)
   ``````
   docker exec -it rbt_app php server/cli.php --autoconfigure-domophone=3
   ``````
