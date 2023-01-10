TODO:

1. ssl для nginx, положить из в:
   ````
   ./_docker/nginx/certs
   ````
2. Clone RBT repo:
   ````
   git clone git@github.com:rosteleset/rbt.git
   ````
3. Init clickhouse tables  
https://github.com/rosteleset/rbt/blob/main/install

4. Start docker containers:
   ````
   docker compose up -d
   ```` 
____
#### Autoconfig intercom 
First time config
   ``````
   docker exec -it rbt_app php server/cli.php --autoconfigure-domophone=3 --first-time
   ``````
Config intercom, config update (added keys or flats)
   ``````
   docker exec -it rbt_app php server/cli.php --autoconfigure-domophone=3
   ``````
