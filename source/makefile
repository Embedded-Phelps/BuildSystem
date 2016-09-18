CC	= gcc
OBJ	= main.o data.o memory.o project_1.o
LINKOBJ = 
LIBS	= 
INCS	= -I ../header
BIN	= main
CFLAGS  = -std=c99 -O0 -Wall -g $(INCS)   
VPATH	= ../source:../header
RM	= rm -f

main: $(OBJ)
	$(CC) -o $@ $(OBJ)

$(OBJ): %.o:%.c
	$(CC) $(CFLAGS) -c $<

main.o: data.h memory.h

.PHONY: clean clean-custom

clean: clean-custom
	${RM} $(OBJ) $(BIN)

