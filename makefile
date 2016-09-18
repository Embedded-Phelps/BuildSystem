SUBDIR = ./source
MAKE = make
export ARCH = _HOST
export CC= gcc

ifeq ($(ARCH), _BBB)
export CC= arm-linux-gnueabi-gcc
endif 

ifeq ($(ARCH), _FRDM)
export CC = arm-none-gnueabi-gcc
endif

subsystem: 
	cd $(SUBDIR) && $(MAKE)
