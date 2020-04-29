# Makefile to interact with terraform
SHELL := /bin/bash

ifndef ACCNAME
$(error ACCNAME is not set)
endif

ifndef REGION
$(error REGION is not set)
endif

ifndef ENVNAME
ENVNAME=$(ACCNAME)
endif

# vars to import
VARS=-var "accname=$(ACCNAME)" \
-var "envname=$(ENVNAME)" \
-var "aws_region=$(REGION)"

# Build tfvars hierarchy for import
VARFILE=
ifneq (,$(wildcard tfvars/default.tfvars))
    VARFILE=-var-file=tfvars/default.tfvars
endif
ifneq (,$(wildcard tfvars/$(ACCNAME).tfvars))
    VARFILE+= -var-file=tfvars/$(ACCNAME).tfvars
endif
ifneq (,$(wildcard tfvars/$(ACCNAME)_$(REGION).tfvars))
    VARFILE+= -var-file=tfvars/$(ACCNAME)_$(REGION).tfvars
endif
ifneq (,$(wildcard tfvars/$(ACCNAME)_$(ENVNAME).tfvars))
    VARFILE+= -var-file=tfvars/$(ACCNAME)_$(ENVNAME).tfvars
endif
ifneq (,$(wildcard tfvars/$(ACCNAME)_$(ENVNAME)_$(REGION).tfvars))
    VARFILE+= -var-file=tfvars/$(ACCNAME)_$(ENVNAME)_$(REGION).tfvars
endif

GPATH=$(shell git rev-parse --git-dir)
CPATH=$(shell pwd)
APATH=$(subst .git,,$(GPATH))
NPATH=$(subst $(APATH),,$(CPATH))
BASENAME=$(shell basename `git rev-parse --show-toplevel`)

SF_BUCKET="terraform-states-$(ACCNAME)"
SF_KEY="$(NPATH)/$(REGION)/terraform.tfstate"
SF_REGION="eu-west-1"

export AWS_DEFAULT_REGION=$(REGION)

begin: plan

clean:
	@echo ${SF_KEY}
	@echo "clean"

init: clean
	@echo "init"

refresh: init
	@echo "refresh"

plan: init
	@echo "plan"

apply:
	@echo "apply"

destroy: init
	@echo "destroy"
