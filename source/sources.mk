SRCS	= main.c data.c memory.c project_1.c
OBJ     = $(patsubst %,%.o,$(basename $(SRCS)))
PREP	= $(patsubst %,%.i,$(basename $(SRCS)))
ASM	= $(patsubst %,%.s,$(basename $(SRCS)))
LIB     = libproject1.a
LIBSRC	= data.c memory.c
AR	= ar
INCS    = -I ../header
BIN     = ../project
CFLAGS  = -std=c99 -O0 -Wall -g 
CPPFLAGS= $(INCS) -D $(ARCH)
PROJ	= -D PROJECT_1
LDFLAGS = -Wl,-Map=$@.map
VPATH   = ../source:../header
RM      = rm -f
DEPDIR = .d
$(shell mkdir -p $(DEPDIR) >/dev/null)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(PROJ) -c
POSTCOMPILE = mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d

.PHONY: build
build: $(BIN)

$(BIN) : $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $(OBJ)
	size --format=berkeley -d $@

.PHONY: preprocess
preprocess: $(SRCS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) -E $^

%.i : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) $< -E -o $@

.PHONY: asm-file
asm-file: $(SRCS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) -S $^

%.s : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) $< -E -o $@
	
%.o : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PROJ) $< -c -o $@

.PHONY: compile-all
compile-all: $(OBJ)

$(OBJ) : $(SRCS) $(DEPDIR)/%.d
	$(COMPILE.c)  $(SRCS)
	$(POSTCOMPILE)
	objdump -d $@

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
	scp $(BIN) root@192.168.7.2:/home/debian/bin

.PHONY:clean
clean:
	$(RM) $(PREP) $(ASM) $(OBJ) $(BIN) $(LIB) $(BIN).map -rf $(DEPDIR) 
