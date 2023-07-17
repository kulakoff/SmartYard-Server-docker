.DEFAULT_GOAL := help

help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

## 1 step
SmartYard-Server_clone_libs: ## Clone RBT libs
	# clone rbt
	git clone --depth=1 https://github.com/rosteleset/rbt.git
	# download server libs
	git clone --depth=1 https://github.com/PHPMailer/PHPMailer SmartYard-Server/server/lib/PHPMailer
	git clone --depth=1 https://github.com/ezyang/htmlpurifier SmartYard-Server/server/lib/htmlpurifier
	git clone -b 1.7.x --depth=1 https://github.com/erusev/parsedown SmartYard-Server/server/lib/parsedown
	# download client libs
	git clone --depth=1 https://github.com/ColorlibHQ/AdminLTE SmartYard-Server/client/lib/AdminLTE
	git clone --depth=1 https://github.com/davidshimjs/qrcodejs SmartYard-Server/client/lib/qrcodejs
	git clone --depth=1 https://github.com/loadingio/loading-bar SmartYard-Server/client/lib/loading-bar
	git clone --depth=1 https://github.com/ajaxorg/ace-builds SmartYard-Server/client/lib/ace-builds
	# install mzfc libs
	docker run --rm -it -v "$(shell pwd)/SmartYard-Server/server/mzfc/mongodb:/app" composer/composer require mongodb/mongodb --ignore-platform-reqs

## 2 step
SmartYard-Server_copy_configs: ## Copy RBT example configs
	# create rbt client config
	cp docker/example_conf/rbt_client_config.json SmartYard-Server/client/config/config.json
	# create SmartYard-Server server config
	cp docker/example_conf/SmartYard-Server_server_config.json SmartYard-Server/server/config/config.json
	# create SmartYard-Server syslog
	cp docker/example_conf/SmartYard-Server_syslog_config.json SmartYard-Server/server/syslog/config.json
	# copy example asterisk config for running
	cp -R docker/asterisk/conf/* SmartYard-Server/install/asterisk/
	# cope default environments
	cp .example.env .env

## 	3 Start RBT services
SmartYard-Server_start:	## Start RBT services
	docker compose up -d

## 4 Stop RBT services
SmartYard-Server_stop:	## Stop RBT services
	docker compose down

SmartYard-Server_restart: ## Restart RBT services
	make SmartYard-Server_stop && make SmartYard-Server_start