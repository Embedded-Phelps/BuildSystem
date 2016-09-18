SRCS	= main.c data.c memory.c project_1.c
OBJ     = $(patsubst %,%.o,$(basename $(SRCS)))
PREP	= $(patsubst %,%.i,$(basename $(SRCS)))
ASM	= $(patsubst %,%.s,$(basename $(SRCS)))
LIB     = libproject1.a
LIBSRC	= data.c memory.c
AR	= ar
INCS    = -I ../header
BIN     = main
CFLAGS  = -std=c99 -O0 -Wall -g 
CFLAGS += -D $(ARCH) -D $(PROJ) 
CPPFLAGS= $(INCS)
VPATH   = ../source:../header
RM      = rm -f

DEPDIR = .d
$(shell mkdir -p $(DEPDIR) >/dev/null)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) -c
POSTCOMPILE = mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d

.PHONY: build
build: $(BIN)

$(BIN) : $(OBJ)
	$(CC) -o $@ $(OBJ)
	size --format=berkeley -d $@

.PHONY: compile-all
compile-all: $(OBJ)

$(OBJ) : $(SRCS) $(DEPDIR)/%.d
	$(COMPILE.c)  $(SRCS)
	$(POSTCOMPILE)

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

-include $(patsubst %,$(DEPDIR)/%.d,$(basename $(SRCS)))	

.PHONY:build-lib
build-lib: $(LIB)

$(LIB) : $(LIBSRC)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $*.o
	$(AR) r $@ $*.o
	$(RM) $*.o

.PHONY:upload
upload: $(BIN)
	scp $(BIN) root@192.168.7.2:/home/debian/bin/test

.PHONY:clean
clean:
	$(RM) $(PREP) $(ASM) $(OBJ) $(BIN) $(LIB)