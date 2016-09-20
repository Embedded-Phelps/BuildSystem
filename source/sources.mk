
## Customizable Section: adapt variables for your project
##=========================================================

# Source files
SRCS	  = main.c data.c memory.c project_1.c

# Project for build
PROJ	  = -D PROJECT_1

# Library Archive
LIB       = libproject1.a

# Source codes for library
LIBSRC	  = data.c memory.c

# include headers files
INCS      = -I ../header

# build target
BIN       = ../project

# Supported C standard option
CSTD      = -std=c99

# Optimization level option
OPT	  = 0

# Warning option
WARNING   = -Wall

# Debug option
DEBUG     = -g

# Flags for generating map file for linker
MAPFILE   = -Wl,-Map=$@.map

#source and header file directory
VPATH     = ../source:../header


## Implicit Section: change the following only when necessary
##=========================================================

# Object files
OBJ       = $(patsubst %,%.o,$(basename $(SRCS)))

# Preprocessed files
PREP	  = $(patsubst %,%.i,$(basename $(SRCS)))

# Assembly files
ASM	  = $(patsubst %,%.s,$(basename $(SRCS)))

#Preprocessor options
CFLAGS   += -O$(OPT)
CFLAGS   += $(CSTD)
CFLAGS   += $(DEBUG)
CFLAGS   += $(WARNING) 
CPPFLAGS += $(INCS) 
CPPFLAGS += -D $(ARCH)

#Linker option
LDFLAGS  += $(MAPFILE)


## Stable Section: Usually the following remains unchanged
##=========================================================

#command used to generate archive
AR	  = ar

# The command used to delete files
RM        = rm -f

# Subdirectory to put dependency files 
DEPDIR    = .d

# Ensure the DEPDIR directory always exists
$(shell mkdir -p $(DEPDIR) >/dev/null)

# GCC-specific flags that convince the compiler to generate dependency files
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

# Rename temperate .d files to real .d files
POSTCOMPILE = mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d

# Define some useful variables
COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(PROJ) -c


.PHONY: build preprocess %.i asm-file %.s compile-all %.o build-lib upload clean 
# Rule for building target
# ===============================================

build: $(BIN)

$(BIN) :$(OBJ)
	$(CC) $(LDFLAGS) -o $@ $(OBJ)
	size --format=berkeley -d $@

# Rule for generating preprocessed files
# ===============================================

preprocess: $(PREP) 

%.i : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) $< -E -o $@

# Rule for generating assembly files
# ===============================================

asm-file: $(ASM)

%.s : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) $< -S -o $@
	
# Rule for compiling for all objects and generating dependency files
# ===============================================

compile-all: $(OBJ)

%.o : %.c $(DEPDIR)/%.d
	#$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) $< -c -o $@
	$(COMPILE.c) $< -o $@
	$(POSTCOMPILE)
	objdump -d $@ #Comment out this command when building for FRDM

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d
-include $(patsubst %,$(DEPDIR)/%.d,$(basename $(SRCS)))	


# Rule for building library archives
# ===============================================

build-lib: $(LIB)

$(LIB) : $(LIBSRC)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $*.o
	$(AR) r $@ $*.o
	$(RM) $*.o

# Rule for uploading target executable file to BeagleBone Black
# =============================================== 

upload: $(BIN)
	scp $(BIN) root@192.168.7.2:/home/debian/bin

# Rule for Cleanning all make output
# ===============================================

clean:
	$(RM) $(PREP) $(ASM) $(OBJ) $(BIN) $(LIB) $(BIN).map -rf $(DEPDIR)

## End of makefile by ShuTing_Guo
##========================================================= 
