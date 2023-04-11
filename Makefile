.DEFAULT_GOAL := help

help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

rbt_clone_libs: ## Clone_rbt_libs
# clone rbt	
	git clone https://github.com/rosteleset/rbt.git
# download server libs
	git clone https://github.com/PHPMailer/PHPMailer rbt/server/lib/PHPMailer
	git clone https://github.com/ezyang/htmlpurifier rbt/server/lib/htmlpurifier
	git clone -b 1.7.x https://github.com/erusev/parsedown rbt/server/lib/parsedown
# download client libs
	git clone https://github.com/ColorlibHQ/AdminLTE rbt/client/lib/AdminLTE
	git clone https://github.com/davidshimjs/qrcodejs rbt/client/lib/qrcodejs
	git clone https://github.com/loadingio/loading-bar rbt/client/lib/loading-bar
	git clone https://github.com/ajaxorg/ace-builds rbt/client/lib/ace-builds	

# install mzfc libs
	composer require mongodb/mongodb --ignore-platform-reqs -d rbt/server/mzfc/mongodb/

## 2 step
rbt_copy_configs: ## Copy rbt example configs 	
# create rbt client config
	cp docker/example_conf/rbt_client_config.json rbt/client/config/config.json 
# create rbt server config
	cp docker/example_conf/rbt_server_config.json rbt/server/config/config.json 
# create rbt syslog	
	cp docker/example_conf/rbt_syslog_config.json rbt/server/syslog/config.json
# copy example asterisk config for running 
	cp -R docker/asterisk/conf/* rbt/install/asterisk/
# cope default enviroments
	cp .example.env .env

rbt_containers_up: ## Start RBT containers
	docker compose up -d
rbt_containers_down: ##  Stop RBT containers
	docker compose down	
rbt_syslog_up: ## Start RBT Syslog service
	docker-compose -f docker-compose-syslogs.yml up -d
rbt_syslog_down: ## Stop RBT Syslog service
	docker-compose -f docker-compose-syslogs.yml down

## 	RBT demo 
rbt_start:	## Start RBT services
	make rbt_containers_up && make rbt_syslog_up
rbt_down:	## Stop RBT services
	make rbt_containers_down && make rbt_syslog_down
