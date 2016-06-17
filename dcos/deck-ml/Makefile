.DEFAULT_GOAL = help
SHELL = /bin/bash

deck-dcos: ## make a DCOS for deck
	${MAKE} -f deck-ml.mk mk

deck-infra-deps: ## make deck's infra. dependencies in DCOS
deck-infra-deps: symlink kafka cassandra cassandra-raw

deck: ## install deck's docker-image in DCOS
	echo '@todo'

kafka: ## make kafka cluster
	./dcos package install --options=kafka.json kafka

cassandra: ## make cassandra cluster
	./dcos package install  --options=cassandra.json cassandra

cassandra-raw: ## make cassandra-raw cluster
	./dcos package install --options=cassandra-raw.json cassandra

LINKS = *.yml dcos lookup_plugins templates tmp venv
symlinks: ## make sym links to docs-bootstrp
	for i in ${LINKS}; do ln -s ../../aws/dcos-bootstrap/$$i; done

clean: ## clean up
	rm -f ${LINKS}

clobber: clean
	${MAKE} -f deck-ml.mk unmk

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: infra kafkka cassandra cassandra-raw symlinks clean
