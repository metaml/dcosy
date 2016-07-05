.PHONY: python install build dcos-bootstrap help
.DEFAULT_GOAL = help

DCOS_BOOTSTRAP_URL = https://github.com/dcos-labs/dcos-bootstrap

install: ## AWS: install dcos 1.7 early access
install: python dcos-bootstrap build

build: ## build dcos-docker
	cd dcos-bootstrap && make

dcos-bootstrap: ## get git repo: dcos-bootstrap
	@if [ ! -d dcos-bootstrap ]; then \
		git clone ${DCOS_BOOTSTRAP_URL}; \
	else \
		(cd dcos-bootstrap && git pull); \
	fi

pkgs: ## install virtualenv
	sudo apt-get install -y python3-venv python3-pip libssl-dev

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
