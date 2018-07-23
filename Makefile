.DEFAULT_GOAL := help
DOCKERSYNC := $(shell command -v docker-sync-stack 2> /dev/null)

build: ## Build the app
	docker-compose stop ;\
	docker-compose build

rebuild: ## Attempt to rebuild the app without cache
	docker-compose rm --stop --force ;\
	docker-compose build --force-rm --no-cache

freshclam:
	docker-compose -f docker-compose.yaml run clamav /usr/bin/freshclam -v

start: ## Start the dev cluster
	docker-compose -f docker-compose.yaml up

run: ## Start the development cluster in detached mode
	docker-compose -f docker-compose.yaml up -d

stop: ## Attempt to stop the dev cluster
	docker-compose -f docker-compose.yaml stop

kill: ## Attempt to kill the dev cluster
	docker-compose -f docker-compose.yaml kill

nuke: ## Kill and Remove defined containers
	docker-compose -f docker-compose.yaml rm --force --stop

connect: ## Attempt to connect to the app on the development cluster
	docker-compose -f docker-compose.yaml exec exim /bin/sh

watchlogs: ## Watch the logs
	docker-compose -f docker-compose.yaml logs -f

.PHONY: help

help: ## Helping devs since 2016
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "For additional commands have a look at the README"
