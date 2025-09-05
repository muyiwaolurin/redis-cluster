## Makefile — Redis 6-node cluster (via shell scripts)

SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:

.PHONY: help start clean restart status down init up create-cluster deps

help:
	@echo "Usage:"
	@echo "  make help     # show this help"
	@echo "  make start    # init configs, start servers, form cluster"
	@echo "  make clean    # stop servers and delete cluster dirs"
	@echo "  make restart  # cleanly restart the cluster"
	@echo ""
	@echo "Advanced (aliases):"
	@echo "  make deps           # install prerequisites (tmux, redis)"
	@echo "  make init           # generate per-port redis configs"
	@echo "  make up             # start tmux session + redis instances"
	@echo "  make create-cluster # create 3 masters / 3 replicas"
	@echo "  make status         # show cluster nodes"
	@echo "  make down           # stop servers and tmux session"

start:
	./scripts/start.sh

clean:
	./scripts/clean.sh

restart:
	./scripts/restart.sh

status:
	./scripts/status.sh

down:
	./scripts/down.sh

init:
	./scripts/init.sh

up:
	./scripts/up.sh

create-cluster:
	./scripts/create_cluster.sh

deps:
	chmod +x ./scripts/deps.sh
	./scripts/deps.sh
