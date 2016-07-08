.PHONY: install launch dcos-installer dcos-docker cli-install-sh dcos-cli stop sh help

.DEFAULT_GOAL := help

install: ## install dcos 1.7 early access and launch
install: dcos-docker dcos-installer launch

launch: ## build dcos-docker and launch
	cd dcos-docker && make MASTERS=1 AGENTS=4

DCOS_INSTALLER_URL = https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh
dcos-installer: ## download dc/os 1.7.0 installer
	[ -f dcos-docker/dcos_generate_config.sh ] \
	|| wget ${DCOS_INSTALLER_URL} -O dcos-docker/dcos_generate_config.sh

DCOS_DOCKER_URL = https://github.com/dcos/dcos-docker
dcos-docker: ## add related git submodule
	[ -d dcos-docker ] || git clone ${DCOS_DOCKER_URL}
	cd dcos-docker && git pull

DCOS_CLI_URL = https://downloads.dcos.io/dcos-cli/install.sh
cli-install-sh: ## dcos cli
	[ -f /tmp/install.sh ] || (cd /tmp && wget ${DCOS_CLI_URL})

dcos-cli: ## install dcos cli
dcos-cli: cli-install-sh
	sudo mkdir -p /opt/dcos && sudo chown -R ${LOGNAME} /opt/dcos
	bash /tmp/install.sh /opt/dcos http://172.17.0.2

clean: ## clean
	sudo rm -rf dcos-docker

stop: IDS = $(shell docker ps -q)
stop: ## stop local dcos
	if [ -n "${IDS}" ]; then docker kill ${IDS}; fi
	docker rm $$(docker ps -q -a)

DOCKER_ID ?= dcos-docker-master1
EXEC ?= /bin/bash
sh: ## run a shell/exec in a docker container; set optional env-var DOCKER_ID
	docker exec --tty --interactive ${DOCKER_ID} ${EXEC}

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
