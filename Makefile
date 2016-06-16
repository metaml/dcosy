.DEFAULT_GOAL = help
SHELL = /bin/bash

install: ## install dcos-cli
install: dcos-cli

aws: ## install tools that installs DCOS in AWS
	cd aws && ${MAKE}

docker: ## install tools that install DCOS in docker (local)
	cd docker && ${MAKE} install

cli: ## install dcos-cli
	cd cli && ${MAKE} install

mk-%: ## make a DCOS env in AWS defined in ./dcos, e.g.: make mk-dcos-ml
	cd dcos/$(subst mk-,,$@) && make -f $(subst mk-,,$@).mk mk

unmk-%: ## unmake a DCOS env in AWS defined in ./dcos, e.g.: make unmk-dcos-ml
	cd dcos/$(subst unmk-,,$@) && make -f $(subst unmk-,,$@).mk unmk

ls: ## list dcos recipes (*.mk file)
	@cd dcos && ls -1 *.mk

init: ## install required dependencies
	sudo apt-get install -y libssl-dev python libpython-dev virtualenv
	cd dcos && git clone git://github.com/ansible/ansible --recursive

help: ## help
	@grep -E '^[a-zA-Z_][a-zA-Z_-%]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: aws cli docker help install
