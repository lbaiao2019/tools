# Makefile to interact with terraform
SHELL := /bin/bash

ACCOUNT := lw-infra
SERVICE := tools
IMAGE := $(ACCOUNT)/$(SERVICE)
TAG := latest

clean:
	@echo "clean"

build: clean
	$(info Make: Building.)
	@docker build -t $(IMAGE):$(TAG) .

run: build
	$(info Make: Running.)
	@docker run -dt --name $(SERVICE) -v ~/$(ACCOUNT):/usr/local/lw-tools $(IMAGE):$(TAG)

destroy:
	$(info Make: Destroying.)
	docker container stop $(SERVICE)
	docker container rm $(SERVICE) --force
	docker image rm $(IMAGE):$(TAG) --force
