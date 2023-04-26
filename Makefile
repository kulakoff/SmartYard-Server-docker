.DEFAULT_GOAL := help

help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

## 1 step
rbt_clone_libs: ## Clone RBT libs
	# clone rbt
	git clone --depth=1 https://github.com/rosteleset/rbt.git
	# download server libs
	git clone --depth=1 https://github.com/PHPMailer/PHPMailer rbt/server/lib/PHPMailer
	git clone --depth=1 https://github.com/ezyang/htmlpurifier rbt/server/lib/htmlpurifier
	git clone -b 1.7.x --depth=1 https://github.com/erusev/parsedown rbt/server/lib/parsedown
	# download client libs
	git clone --depth=1 https://github.com/ColorlibHQ/AdminLTE rbt/client/lib/AdminLTE
	git clone --depth=1 https://github.com/davidshimjs/qrcodejs rbt/client/lib/qrcodejs
	git clone --depth=1 https://github.com/loadingio/loading-bar rbt/client/lib/loading-bar
	git clone --depth=1 https://github.com/ajaxorg/ace-builds rbt/client/lib/ace-builds
	# install mzfc libs
	docker run --rm -it -v "$(shell pwd)/rbt/server/mzfc/mongodb:/app" composer/composer require mongodb/mongodb --ignore-platform-reqs

## 2 step
rbt_copy_configs: ## Copy RBT example configs
	# create rbt client config
	cp docker/example_conf/rbt_client_config.json rbt/client/config/config.json
	# create rbt server config
	cp docker/example_conf/rbt_server_config.json rbt/server/config/config.json
	# create rbt syslog
	cp docker/example_conf/rbt_syslog_config.json rbt/server/syslog/config.json
	# copy example asterisk config for running
	cp -R docker/asterisk/conf/* rbt/install/asterisk/
	# cope default environments
	cp .example.env .env

## 	3 Start RBT services
rbt_start:	## Start RBT services
	docker compose up -d

## 4 Stop RBT services
rbt_stop:	## Stop RBT services
	docker compose down