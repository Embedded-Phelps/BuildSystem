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
	*aptr_1 = 31;	//change it to Macro
	printf("%10p,%10p,%10p\n",aptr_1,aptr_2,aptr_3);
	for (i=1;i<16;i++)
		* (aptr_1+i) = *(aptr_1+i-1)+1;
	printf("%c\n",*aptr_1);
	printf("%c%c\n", *(aptr_1+1),*(aptr_1+2));
	my_memzero(aptr_3,16);
	for (i=0;i<32;i++)
        	printf("%c",*(aptr_1+i));
	printf("\n");
	printf("%10p,%10p,%10p\n",aptr_1,aptr_2,aptr_3);
	my_memmove(aptr_1,aptr_3,8);
	for (i=0;i<32;i++)
                printf("%c",*(aptr_1+i));
	printf("\n");
	printf("%10p,%10p,%10p\n",aptr_1,aptr_2,aptr_3);
	my_memmove(aptr_2,aptr_1,16);
	for (i=0;i<32;i++)
                printf("%c",*(aptr_1+i));
	printf("\n");
	my_reverse(aptr_1,32);
	for (i=0;i<32;i++)
		printf("%c",*(aptr_1+i));
	printf("\n");
}	
