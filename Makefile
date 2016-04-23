install: ## install dcos 1.7 early acess: "make install" to start
install: dcos-docker dcos-installer build

build: ## build dcos-docker
	cd dcos-docker && make

dcos-installer: ## download dc/os 1.7.0 installer
	wget ${DCOS_INSTALLER_URL} -O dcos-docker/dcos_generate_config.sh

dcos-docker: ## git clone
	git clone ${DCOS_DOCKER_URL}

clean: ## clean
	sudo rm -rf dcos-docker

ps: ## list docker container
	docker ps --all

DOCKER_ID ?= dcos-docker-master1
EXEC ?= /bin/bash

sh: ## run a shell/exec in docker container: set DOCKER_ID
	docker exec --tty --interactive ${DOCKER_ID} ${EXEC}

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
        | awk 'BEGIN {FS = ":.*?## "}; \
	       {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

DCOS_INSTALLER_URL = https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh
DCOS_DOCKER_URL = https://github.com/dcos/dcos-docker

.DEFAULT_GOAL := help
