SUBDIR = ./source
MAKE = make -f sources.mk
SOURCEMAKE = cd $(SUBDIR) && $(MAKE)
export PROJ = 
export ARCH = _HOST
export CC= gcc

ifeq ($(ARCH), _BBB)
export CC= arm-linux-gnueabi-gcc
endif 

ifeq ($(ARCH), _FRDM)
export CC = arm-none-gnueabi-gcc
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
