.DEFAULT_GOAL := help

ORG = secure-email
NAME = rspamd
IMAGE = $(ORG)/$(NAME)
VERSION = 0.0.1
PORT_INTERNAL = 11334
PORT_EXTERNAL = 11334

build: ## Build it
	docker build --pull -t $(IMAGE) .

buildnocache: ## Build it without using cache
	docker build --pull -t $(IMAGE) --no-cache .

start: ## run it attached
	docker run -p $(PORT_EXTERNAL):$(PORT_INTERNAL) --name $(NAME)_run --rm -it $(IMAGE)

run: ## run it detached
	docker run -p $(PORT_EXTERNAL):$(PORT_INTERNAL) --name $(NAME)_run --rm -id $(IMAGE)

runshell: ## run the container with an interactive shell
	docker run -p $(PORT_EXTERNAL):$(PORT_INTERNAL) --name $(NAME)_run --rm -it $(IMAGE) /bin/sh

connect: ## connect to it
	docker exec -it $(NAME)_run /bin/sh

watchlog: ## connect to it
	docker logs -f $(NAME)_run

kill: ## kill it
	docker kill $(NAME)_run

tag: ## Tag it with $(VERSION)
	docker tag $(IMAGE):latest $(IMAGE):$(VERSION)

release: tag ## Create and push release to docker hub manually
	@if ! docker images $(IMAGE) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(IMAGE):$(VERSION)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

.PHONY: help

help: ## Helping devs since 2016
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "For additional commands have a look at the README"

