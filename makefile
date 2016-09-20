#==========================================================
#
# Makefile for ECEN5013 Projects
#
# Author: ShuTing Guo
#
# Date: 9/19/2016
#
# Description: 
#
# This makefile is used for the ECEN 5013 projects,
# for more information about its operation and syntax
# please refer to the README.md file
#
#==========================================================

# Include the sub-makefile 
SUBDIR = ./source
MAKE = make -f sources.mk
SOURCEMAKE = cd $(SUBDIR) && $(MAKE) 

# Target architecture is HOST at default
export ARCH ?= _HOST

# Use GCC at default
export CC = gcc

# If target architecture is Beaglebone Black
# use cross-compiler
ifeq ($(ARCH), _BBB)
export CC = arm-linux-gnueabi-gcc
endif 

# If target architecture is FRDM KL25Z
# use cross-compiler
ifeq ($(ARCH), _FRDM)
export CC = arm-none-eabi-gcc --specs=nosys.specs
endif

subsystem: 
	$(SOURCEMAKE)

.PHONY: build preprocess %.i asm-file %.s compile-all %.o build-lib upload clean

build:
	$(SOURCEMAKE) $@

preprocess:
	$(SOURCEMAKE) $@

%.i : 
	$(SOURCEMAKE) $@

asm-file:
	$(SOURCEMAKE) $@

%.s :
	$(SOURCEMAKE) $@

compile-all: 
	$(SOURCEMAKE) $@

%.o :
	$(SOURCEMAKE) $@
 
build-lib:
	$(SOURCEMAKE) $@

upload:
	$(SOURCEMAKE) $@

clean:
	$(SOURCEMAKE) $@

## End of makefile by ShuTing Guo
##=========================================================
