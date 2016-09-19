#include <stdio.h>
#include <stdint.h>
#include "memory.h"
#include "data.h"

void project_1_report(){
    uint8_t array[32];
    uint8_t * aptr_1 = array;
    uint8_t * aptr_2 = &array[8];
    uint8_t * aptr_3 = &array[16];
    uint8_t i;
    *aptr_1 = 31;	
    for (i=1;i<16;i++)
        * (aptr_1+i) = *(aptr_1+i-1)+1;
    my_memzero(aptr_3,16);
    my_memmove(aptr_1,aptr_3,8);
    my_memmove(aptr_2,aptr_1,16);
    my_reverse(aptr_1,32);
    dump_memory(aptr_1, 32);
}	
