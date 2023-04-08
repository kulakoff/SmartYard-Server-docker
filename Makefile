.DEFAULT_GOAL := help

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
up: ## up containers
	docker compose up -d
down: ## down containers
	docker compose down
syslog-up: ## up syslog containers
	docker-compose -f docker-compose-syslogs.yml up -d
syslog-down: ## down syslog containers
	docker-compose -f docker-compose-syslogs.yml down
all-start: ##all start
	make syslog-up && make up
all-down: ##all start
	make syslog-down && make down
