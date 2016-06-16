.DEFAULT_GOAL := help

DCOS_INSTALLER_URL = https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh
DCOS_BOOTSTRAP_URL = https://github.com/dcos-labs/dcos-bootstrap

install: ## AWS: install dcos 1.7 early access
install: add-submod

build: ## build dcos-docker
	cd dcos-docker && make

SUBMODULE = ${DCOS_BOOTSTRAP_URL}
add-submod: ## add related git submodule
	@if [ ! -d lib/docket ]; then \
		git submodule add --force ${SUBMODULE} dcos-bootstrap; \
		echo added dcos-bootstrap submodule; \
	elif [ ! -f lib/docket/Makefile ]; then \
		if ! git rm -f --cached dcos-bootstrap 2>&1; then ${MAKE} clean; fi; \
		git submodule add --force ${SUBMODULE} dcos-bootstrap; \
		echo added dcos-bootstrap submodule; \
	else \
		echo noop: dcos-bootstrap already exists; \
	fi

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
