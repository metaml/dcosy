.DEFAULT_GOAL = help

DCOS_TASK_DIR ?= ~${LOGNAME}/proj/deck/lib/dcos/deck-ml
DCOS_BOOTSTRAP_URL = https://github.com/dcos-labs/dcos-bootstrap

dcos: ## install dcos 1.7 early access in AWS
dcos: python dcos-bootstrap build

build: ## build dcos-docker
	cd dcos-bootstrap \
	&& make AWS_REGION=us-west-2 DCOS_WORKER_NODES=9

cassandra: ## deploy cassandra cluster to AWS:VPC
	cd dcos-bootstrap \
	&& ./dcos marathon app add ${DCOS_TASK_DIR}/deck-cassandra.json

cassandra-raw: ## deploy cassandra-raw cluster to AWS:VPC
	cd dcos-bootstrap \
	&& ./dcos marathon app add ${DCOS_TASK_DIR}/deck-cassandra-raw.json

zookeeper: ## deploy zookeeper cluster to AWS:VPC
	cd dcos-bootstrap \
	&& ./dcos marathon app add ${DCOS_TASK_DIR}/deck-zookeeper.json

kafka: ## deploy zookeeper cluster to AWS:VPC
	cd dcos-bootstrap \
	&& ./dcos marathon app add ${DCOS_TASK_DIR}/deck-kafka.json

dev-scala: ## deploy dev-scala to AWS:VPC
	cd dcos-bootstrap \
	&& ./dcos marathon app add ${DCOS_TASK_DIR}/dev-scala.json

dcos-login: ## authenticate to DCOS
	cd dcos-bootstrap && ./dcos auth login

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

.PHONY: python install build dcos-bootstrap help
