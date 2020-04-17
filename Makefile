# Makefile to interact with terraform
SHELL := /bin/bash


begin: plan

clean:
	@echo "clean"

init: clean
	@echo "init"

refresh: init
	@echo "refresh"

plan: init
	@echo "plan"

apply:
	@echo "apply"
	docker build -t test/volume .
	#docker run -dt test/volume
	docker run -dt -v ~/test:/usr/local/lw-tools test/volume

destroy: init
	@echo "destroy"
	docker container rm $(docker container ls -lq) --force
	docker image rm $(docker images -q) --force
	docker volume rm $(docker volume ls -q)
