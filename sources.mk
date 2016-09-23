vpath %.c source
vpath %.o obj

# Source files
SRCS = main.c data.c memory.c project_1.c

# include headers files
INCS      = ./header

# Preprocessed files 
PREP_DIR = ./prep
PREP = $(patsubst %,%.i,$(basename $(SRCS)))

# Assembly files
ASM_DIR = ./asm
ASM	  = $(patsubst %,%.s,$(basename $(SRCS)))

# Object files
OBJ_DIR = ./obj
OBJ = $(patsubst %,%.o,$(basename $(SRCS)))

## End of makefile by ShuTing_Guo
