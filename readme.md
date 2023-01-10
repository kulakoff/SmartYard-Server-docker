TODO:

1. Copy enviroments
   ````
   cp .example.env .env
   ````
2. Make ssl for NGINX and copy to dir:
   ````
   ./_docker/nginx/certs
   ````
3. Clone RBT repo:
   ````
   git clone git@github.com:rosteleset/rbt.git
   ````
4. Config RBT, read the docs:  
   https://github.com/rosteleset/rbt/blob/main/install/03.install.md
   
5. Init clickhouse tables  
   https://github.com/rosteleset/rbt/blob/main/install

6. Start docker containers:
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
