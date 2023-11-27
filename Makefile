.DEFAULT_GOAL := help

help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

## 1 step
sys_clone_libs: ## Clone SmartYard-Server libs
	# clone SmartYard-Server
	#git clone --depth=1 https://github.com/rosteleset/SmartYard-Server.git
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

	# install mzfc libs
	docker run --rm -it -v "$(shell pwd)/SmartYard-Server/server/mzfc/mongodb:/app" composer/composer require mongodb/mongodb --ignore-platform-reqs

## 2 step
sys_copy_configs: ## Copy SmartYard-Server example configs
	# create SmartYard-Server client config
	cp docker/example_conf/SmartYard-Server_client_config.json SmartYard-Server/client/config/config.json
	# create SmartYard-Server server config
	cp docker/example_conf/SmartYard-Server_server_config.json SmartYard-Server/server/config/config.json
	# create SmartYard-Server syslog
	cp docker/example_conf/SmartYard-Server_syslog_config.json SmartYard-Server/server/syslog/config.json
	# copy example asterisk config for running
	cp -R docker/asterisk/conf/* SmartYard-Server/install/asterisk/
	# cope default environments
	cp .example.env .env

## 	3 Start SmartYard-Server services
sys_start:	## Start RBT services
	docker compose up -d

## 4 Stop RBT services
sys_stop:	## Stop RBT services
	docker compose down

sys_restart: ## Restart RBT services
	make sys_stop && make sys_start