.DEFAULT_GOAL = help
SHELL = /bin/bash

deck-dcos: ## make a DC/OS for deck in AWS
deck-dcos: symlinks
	${MAKE} -f deck-ml.mk mk

deck-infra-deps: ## make deck's infra. dependencies in DCOS
deck-infra-deps: symlinks kafka cassandra cassandra-raw

deck: ## install deck in DCOS
	echo '@todo'

kafka: ## install a kafka cluster in DCOS
	./dcos package install --options=kafka.json kafka

deck-cassandra: ## install a cassandra cluster in DCOS
	./dcos marathon app add deck-cassandra.json

deck-cassandra-raw: ## install a cassandra-raw cluster in DCOS
	./dcos marathon app add deck-cassandra-raw.json

marathon-lb: ## install a marathon load-balancer in DCOS
	./dcos package install marathon-lb

docker-registry: ## install a docker-registry in DCOS
	./dcos marathon app add docker-registry.json

dev-scala: ## install dev-scala (docker) in DCOS
	./dcos marathon app add dev-scala.json

login: ## login to your DCOS
	./dcos auth login

LINKS = *.yml dcos lookup_plugins templates tmp venv
symlinks: ## make sym links to docs-bootstrp
	for i in ${LINKS}; do ln -fs ../../aws/dcos-bootstrap/$$i; done

clean: ## clean up
	rm -f ${LINKS}

clobber: ## clobber your DCOS
clobber: clean
	${MAKE} -f deck-ml.mk unmk

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: infra kafkka cassandra cassandra-raw symlinks clean
