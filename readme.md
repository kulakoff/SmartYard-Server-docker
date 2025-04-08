# SYS - SmartYard-Server
#### Only test, not for production!
1. ### Clone repos 
    ```bash
    make rbt_clone_libs
    ```
2. Create docker shared network
   ```shell
   docker network create --driver bridge --subnet=192.168.100.0/24 shared-network-dev 
   ```

3. ### Edit config files
    #### set your external ip or domain in example config files:
    - client config: docker/example_conf/rbt_client_config.json
    - server config: docker/example_conf/rbt_server_config.json

    ```bash
    sed -i 's/127.0.0.2/rbt-domain.com/g' docker/example_conf/SmartYard-Server_*.json
    ```
4. ### ENV
   Create `.env` file from example
   ```shell
   cp .example.env .env
   ```

5. ### Make your SSL certificate
    Make ssl for NGINX and copy to dir docker/nginx/certs:  
    use [acme.sh](https://github.com/acmesh-official/acme.sh)
    copy do this dir or use default or use self-signed SSL:
   ````
   docker/nginx/conf.d/certs/nginx.key
   docker/nginx/conf.d/certs/nginx.crt
   ````

6. #### Copy configs to SmartYard-Server project
    copy server, client and asterisk configs
    ```shell
    make rbt_copy_configs
    ```

7. ### Start SmartYard-Server
    ```shell
    sudo make rbt_start
    ```

8. ### Stop SmartYard-Server
    ```shell
    sudo make sys_down
    ``` 
---
### other
run include kamailio containers
```shell
docker compose --profile sbc up -d 
```
stop
```shell
docker compose --profile sbc dwon
```

---
### Prometheus stack
start
```shell
docker compose -f ./SmartYard-Server/install/prometheus_stack/docker-compose.yml up -d
```
stop
```shell
docker compose -f ./SmartYard-Server/install/prometheus_stack/docker-compose.yml down
```
### Prometheus custom exporter
start
```shell
docker compose -f ./SmartYard-Server/server/services/sys_exporter/docker-compose.yml up -d
```
stop
```shell
docker compose -f ./SmartYard-Server/server/services/sys_exporter/docker-compose.yml down
```
