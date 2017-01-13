DBG_MAKEFILE ?=
ifeq ($(DBG_MAKEFILE),1)
    $(warning ***** starting Makefile for goal(s) "$(MAKECMDGOALS)")
    $(warning ***** $(shell date))
else
    # If we're not debugging the Makefile, don't echo recipes.
    MAKEFLAGS += -s
endif

# Metadata for driving the build lives here.
META_DIR := .make
SHELL := /usr/bin/env bash
PLANTUML_VERSION := 8053
CONTAINER_IMAGE := docker-graphics
CONTAINER_NONPRIVILEDGED_USER := graphics
CONTAINER_NONPRIVILEDGED_USER_HOMEDIR := /home/graphics
CONTAINER_NAME := testcontainer

.PHONY: help build_image test_image

default: help

help:
	@echo "---> Help menu:"
	@echo "supported make targets:"
	@echo ""
	@echo "---"
	@echo ""
	@echo "Help output:"
	@echo "make help"
	@echo ""
	@echo "Builds the docker image artifact"
	@echo "make build_image"
	@echo ""
	@echo "Test the docker image artifact"
	@echo "make test_image"
	@echo ""

build_image :
	docker build -t $(CONTAINER_IMAGE) --build-arg PLANTUML_VERSION=$(PLANTUML_VERSION) --build-arg CONTAINER_NONPRIVILEDGED_USER=$(CONTAINER_NONPRIVILEDGED_USER) .

test_image :
	docker run --rm --name $(CONTAINER_NAME) -v $(CURDIR)/tests:$(CONTAINER_NONPRIVILEDGED_USER_HOMEDIR)/tests docker-graphics dot -v -Tpng -o $(CONTAINER_NONPRIVILEDGED_USER_HOMEDIR)/test.png $(CONTAINER_NONPRIVILEDGED_USER_HOMEDIR)/tests/test.dot
	docker run --rm --name $(CONTAINER_NAME) -v $(CURDIR)/tests:$(CONTAINER_NONPRIVILEDGED_USER_HOMEDIR)/tests docker-graphics /usr/bin/java -Djava.awt.headless=true -verbose:class -jar /plantuml.jar -o $(CONTAINER_NONPRIVILEDGED_USER_HOMEDIR)/tests/*.puml
