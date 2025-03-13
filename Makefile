.DEFAULT_GOAL := help

# Load .env file
include .env

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "}; /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

## 1 step
rbt_clone_libs: ## Clone SmartYard-Server libs
	# clone SmartYard-Server
	git clone https://github.com/rosteleset/SmartYard-Server.git

	# download server libs
	git clone --depth=1 https://github.com/PHPMailer/PHPMailer SmartYard-Server/server/lib/PHPMailer
	git clone --depth=1 https://github.com/ezyang/htmlpurifier SmartYard-Server/server/lib/htmlpurifier
	git clone -b 1.7.x --depth=1 https://github.com/erusev/parsedown SmartYard-Server/server/lib/parsedown

	# download client libs
	git clone --branch v3.2.0 --depth=1 https://github.com/ColorlibHQ/AdminLTE SmartYard-Server/client/lib/AdminLTE
	git clone --depth=1 https://github.com/davidshimjs/qrcodejs SmartYard-Server/client/lib/qrcodejs
	git clone --depth=1 https://github.com/loadingio/loading-bar SmartYard-Server/client/lib/loading-bar
	git clone --depth=1 https://github.com/ajaxorg/ace-builds SmartYard-Server/client/lib/ace-builds
	git clone --depth=1 https://github.com/Leaflet/Leaflet SmartYard-Server/client/lib/Leaflet
	npm --prefix SmartYard-Server/client/lib/Leaflet/ install
	npm --prefix SmartYard-Server/client/lib/Leaflet run build

	# install composer apps
	docker run --rm -it -v "$(pwd)/SmartYard-Server/server:/app" composer/composer install --ignore-platform-reqs

## 2 step
rbt_copy_configs: ## Copy SmartYard-Server example configs
	cp docker/example_conf/SmartYard-Server_client_config.json SmartYard-Server/client/config/config.json
	cp docker/example_conf/SmartYard-Server_server_config.json SmartYard-Server/server/config/config.json
	cp docker/example_conf/SmartYard-Server_syslog_config.json SmartYard-Server/server/services/event/config.json
	cp -R docker/asterisk/conf/* SmartYard-Server/asterisk/
	cp .example.env .env

rbt_init_config: ## SmartYard-Server initial config
	docker exec -it rbt_app_$(RBT_INSTANCE) php server/cli.php --init-db
	docker exec -it rbt_app_$(RBT_INSTANCE) php server/cli.php --init-clickhouse-db
	docker exec -it rbt_app_$(RBT_INSTANCE) php server/cli.php --admin-password=$(RBT_ADMIN_PASSWORD)
	docker exec -it rbt_app_$(RBT_INSTANCE) php server/cli.php --reindex
	docker exec -it rbt_app_$(RBT_INSTANCE) php server/cli.php --install-crontabs

## 3 step
rbt_start: ## Start RBT services
	docker compose up -d

## 4 step
rbt_stop: ## Stop RBT services
	docker compose down

rbt_restart: ## Restart RBT services
	docker compose restart
