.DEFAULT_GOAL := help

DCOS_CLI_URL = https://downloads.dcos.io/dcos-cli/install.sh

install: ## install dcos-cli
install: install-sh dcos-cli

install-sh: ## get install.sh
	wget ${DCOS_CLI_URL} -O /tmp/install.sh

dcos-cli: ## install dcos cli
	bash /tmp/install.sh /opt/dcos http://172.17.0.2

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
        | awk 'BEGIN {FS = ":.*?## "}; \
	       {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: help install dcos-cli
