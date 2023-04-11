#### Only test, not for production!
1. ### Clone repos
    ```
    make rbt_clone_libs
    ```

2. ### Edit config files
    #### set your external ip or domain in example config files:
    - client config: docker/example_conf/rbt_client_config.json
    - server config: docker/example_conf/rbt_server_config.json

    ```
    sed -i 's/127.0.0.2/rbt-domain.com/g' docker/example_conf/rbt_*.json
    ```

3. ### Make your SSL certificate
    Make ssl for NGINX and copy to dir docker/nginx/certs:  
    use [acme.sh](https://github.com/acmesh-official/acme.sh)
    copy do this dir or uise default or use self-signed SSL:
   ````
   docker/nginx/conf.d/certs/nginx.key
   docker/nginx/conf.d/certs/nginx.crt
   ````

4. #### Copy configs to rbt project
    copy server, client and asterisk configs
    ```
    make rbt_copy_configs
    ```

5. ### Start RBT
    ```
    make rbt_start
    ```

6. ### Init db, set admin password
    ````
    docker exec -it rbt_app php server/cli.php --init-db
    docker exec -it rbt_app php server/cli.php --admin-password=<your very secret admin password>
    docker exec -it rbt_app php server/cli.php --reindex
    docker exec -it rbt_app php server/cli.php --install-crontabs
    ````

7. ### Stop RBT
    ```
    make rbt_down
    ```


