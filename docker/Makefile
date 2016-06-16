.DEFAULT_GOAL := help

DCOS_INSTALLER_URL = https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh
DCOS_DOCKER_URL = https://github.com/dcos/dcos-docker

install: ## install dcos 1.7 early access: kickoff target
install: dcos-docker dcos-installer build

build: ## build dcos-docker
	cd dcos-docker && make

dcos-installer: ## download dc/os 1.7.0 installer
	wget ${DCOS_INSTALLER_URL} -O dcos-docker/dcos_generate_config.sh

SUBMODULE = ${DCOS_INSTALLER_URL}
add-submod: ## add related git submodule
	@if [ ! -d lib/docket ]; then \
		git submodule add --force ${SUBMODULE} dcos-docker; \
		echo added dcos-docker submodule; \
	elif [ ! -f lib/docket/Makefile ]; then \
		if ! git rm -f --cached dcos-docker 2>&1; then ${MAKE} clean; fi; \
		git submodule add --force ${SUBMODULE} dcos-docker; \
		echo added dcos-docker submodule; \
	else \
		echo noop: dcos-docker already exists; \
	fi

cli-install-sh: ## dcos cli
	wget ${DCOS_INSTALLER_URL} -O /tmp/install.sh

dcos-cli: ## install dcos cli
dcos-cli: clil-install-sh
	bash /tmp/install.sh /opt/dcos http://172.17.0.2

clean: ## clean
	sudo rm -rf dcos-docker

stop: DIDS = $(shell docker ps -q)
stop: ## stop local dcos
	if [ -n "${DIDS}" ]; then docker kill $DIDS; fi
	docker rmi $$(docker ps -q -a)

DOCKER_ID ?= dcos-docker-master1
EXEC ?= /bin/bash
sh: ## run a shell/exec in a docker container; set optional env-var DOCKER_ID
	docker exec --tty --interactive ${DOCKER_ID} ${EXEC}

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
