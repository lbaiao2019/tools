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

GPATH=$(shell git rev-parse --git-dir)
ifeq (,$(findstring ecs, $(GPATH)))
ifndef VPCNAME
$(error VPCNAME is not set)
endif
endif

# vars to import
VARS=-var "accname=$(ACCNAME)" \
-var "envname=$(ENVNAME)" \
-var "aws_region=$(REGION)" \
-var "vpc_name=$(VPCNAME)"

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
SF_REGION="eu-west-1"

ifeq ($(BASENAME),lw-platform)
	SPATH=$(subst micro-service,service,$(NPATH))
else
	SPATH=$(NPATH)
endif
SF_KEY="$(ENVNAME)/$(SPATH)/$(REGION)/terraform.tfstate"

export AWS_DEFAULT_REGION=$(REGION)

begin: plan

clean:
	rm -rf .terraform ./modules tfplan

init: clean
	terraform get .
	terraform init -backend-config="bucket=$(SF_BUCKET)" -backend-config="key=$(SF_KEY)" -backend-config="region=$(SF_REGION)"

refresh: init
	terraform refresh $(VARS) $(VARFILE) .

plan: init
	@echo "--------------------"
		@echo ${GPATH}
		@echo ${CPATH}
		@echo ${APATH}
		@echo ${NPATH}
		@echo ${BASENAME}
		@echo ${SF_KEY}
		@echo ${SPATH}
	@echo "--------------------"

	terraform plan -detailed-exitcode $(VARS) $(VARFILE) -out tfplan .;EXC=$$?;if [ $$EXC -eq 1 ]; then exit 1; else if [ $$EXC -eq 0 ]; then rm -f tfplan; fi; exit 0; fi;

apply:
	#terraform apply tfplan
	rm tfplan

destroy: init
	#terraform plan -destroy $(VARS) $(VARFILE) .
	#terraform destroy $(VARS) $(VARFILE) .
