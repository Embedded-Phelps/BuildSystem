########################################################
#
# Makefile for ECEN5013 Projects
#
# Author: ShuTing Guo
#
# Date: 9/18/2016
#
# Description: 
#
# This makefile is used for the ECEN 5013 projects,
# for more information about its operation and syntax
# please refer to the README.md file
#
#########################################################

SUBDIR = ./source
MAKE = make -f sources.mk
SOURCEMAKE = cd $(SUBDIR) && $(MAKE) 
export ARCH ?= _HOST
export CC ?= gcc

ifeq ($(ARCH), _BBB)
export CC = arm-linux-gnueabi-gcc
endif 

ifeq ($(ARCH), _FRDM)
export CC = arm-none-eabi-gcc
endif

subsystem: 
	$(SOURCEMAKE)

.PHONY:preprocess
preprocess:
	$(SOURCEMAKE) $@
%.i : 
	$(SOURCEMAKE) $@

.PHONY: compile-all
compile-all: 
	$(SOURCEMAKE) $@
%.o :
	$(SOURCEMAKE) $@
 
.PHONY: build
build:
	$(SOURCEMAKE) $@

.PHONY: upload
upload:
	$(SOURCEMAKE) $@

.PHONY: build-lib
build-lib:
	$(SOURCEMAKE) $@

.PHONY: clean
clean:
	$(SOURCEMAKE) $@
