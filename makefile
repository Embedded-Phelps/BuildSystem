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

## Customizable Section: adapt variables for your project
##=========================================================

# Include the sub-makefile 
include sources.mk

# Project for build
PROJ = PROJECT_1

# Library Archive
LIB = libproject1.a

# Source codes for library
LIBSRC = source/data.c source/memory.c 

# build target
BIN = project

# Supported C standard option
CSTD = -std=c99

# Optimization level option
OPT = 0

# Warning option
WARNING = -Wall

# Debug option
DEBUG = -g

#configure setting for uploading to BeagleBone Black
_BBB_USER = root
_BBB_IP = 192.168.7.2
_BBB_DERETORY = /home/debian/bin

#configure setting for uploading to FRDM
_FRDM_PATH = /media/$$USER/FRDM-KL25Z

## Implicit Section: change the following only when necessary
##=========================================================

#Compiler options
CFLAGS += -O$(OPT)
CFLAGS += $(CSTD)
CFLAGS += $(DEBUG)
CFLAGS += $(WARNING) 

#Preprocessor options
CPPFLAGS += -I $(INCS)
CPPFLAGS += -D$(PROJ) 

# Flags for generating map file for linker
MAPFILE = -Wl,-Map=$(BIN).map

#Linker option
LDFLAGS += $(MAPFILE)

## Stable Section: Usually the following remains unchanged
##=========================================================

# build based on the target architecture
# CC: compiler
# SIZE: GNU size function
# OBJDUMP: GNU objdump function
# AR: GNU ar utility
# REMOTE: upload path

ifeq ($(ARCH), _BBB)
CC = arm-linux-gnueabihf-gcc
CFLAGS += -march=armv7-a -mtune=cortex-a8 -mfpu=neon
SIZE = arm-linux-gnueabihf-size
OBJDUMP = arm-linux-gnueabihf-objdump
AR = arm-linux-gnueabihf-ar
REMOTE = $(_BBB_USER)@$(_BBB_IP):$(_BBB_DERETORY)

else ifeq ($(ARCH),_FRDM)
CC = arm-none-eabi-gcc
CFLAGS += --specs=nosys.specs
SIZE = arm-none-eabi-size
OBJDUMP = arm-none-eabi-objdump
AR = arm-none-eabi-ar
REMOTE = $(_FRDM_PATH)

else
CC = gcc
SIZE = size
OBJDUMP = objdump
AR = ar

endif

# Define some useful variables
PREPROCESS = $(CC) $(CFLAGS) $(CPPFLAGS) -E
ASSEMBLE = $(CC) $(CFLAGS) $(CPPFLAGS) -S
COMPILE = $(CC) $(CFLAGS) $(CPPFLAGS) -c
GENERATEDEP = $(CC) $(CPPFLAGS) -M

.PHONY: build preprocess %.i asm-file %.s compile-all %.o build-lib upload clean 
# Rule for building target
# ===============================================
build: $(BIN)

$(BIN) :$(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $(OBJ_DIR)/*.o
	@if [ ! -d ./.d ];then mkdir ./.d ;fi
	$(GENERATEDEP) source/*.c > ./.d/$(BIN).dep
	$(SIZE) --format=berkeley -d $@

# Rule for generating preprocessed files
# ===============================================

preprocess: $(PREP) 

%.i : %.c
	@if [ ! -d ./prep ];then mkdir ./prep ;fi
	$(PREPROCESS) $< -o $(PREP_DIR)/$@

# Rule for generating assembly files
# ===============================================

asm-file: $(ASM)

%.s : %.i
	@if [ ! -d ./asm ];then mkdir ./asm ;fi
	$(ASSEMBLE) $(PREP_DIR)/$< -o $(ASM_DIR)/$@
	
# Rule for compiling for all objects and generating dependency files
# ===============================================

compile-all: $(OBJ)

%.o : %.s #$(DEPDIR)/%.d
	@if [ ! -d ./obj ];then mkdir ./obj ;fi
	$(COMPILE) $(ASM_DIR)/$< -o $(OBJ_DIR)/$@
	#$(POSTCOMPILE)

# Rule for objdump
# ===============================================
objdump: $(BIN)
	$(OBJDUMP) -D $(BIN)

# Rule for building library archives
# ===============================================

build-lib: $(LIB)

$(LIB) : $(LIBSRC)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $*.o
	$(AR) r $@ $*.o
	$(RM) $*.o

# Rule for uploading target executable file to BBB or FRDM
# =============================================== 

upload: $(BIN)
	scp $(BIN) $(REMOTE)

# Rule for Cleanning all make output
# ===============================================

clean:
	rm -f $(BIN) $(BIN).map $(LIB)
	rm -rf $(PREP_DIR) $(ASM_DIR) $(OBJ_DIR) .d

## End of makefile by ShuTing Guo
##=========================================================
