.DEFAULT_GOAL = help
SHELL = /bin/bash
# create a public key from a private one, e.g.:
#   ssh-keygen -y -f dev_pbe_key > dev_pbe_key.pem
export AWS_REGION        = us-west-2
export DCOS_ADMIN_KEY    = ~/.ssh/dev_pbe_key.pub
export DCOS_CLUSTER_NAME = deck-ml
export DCOS_WORKER_NODES = 9

mk: ## make a "deck" DCOS infrastructure in AWS
	pushd ../ansible \
	&& source hacking/env-setup \
	&& popd \
	&& cd ../../aws/dcos-bootstrap \
	&& ${MAKE} bootstrap

unmk: ## unmake the "deck" DCOS infrastructure
	pushd ../ansible \
	&& source hacking/env-setup \
	&& popd \
	&& cd ../../aws/dcos-bootstrap \
	&& ${MAKE} destroy

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
	@echo "NB: <dcosy>/aws/dcos-bootstrap/Makefile has the complete set of env vars"

.PHONY: create destroy
