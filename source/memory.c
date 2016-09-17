#include <stdio.h>
#include <stdint.h>

int8_t my_memmove(uint8_t * src, uint8_t * dst, uint32_t length){
	if (length == 0)
		return 'F';
	if((NULL==src)||(NULL==dst))
		return 'F';
	uint32_t i;
	uint8_t * psrc = (uint8_t *) src;
	uint8_t * pdst = (uint8_t *) dst;
	if ((pdst <= psrc) || (pdst > (psrc+length))){
		printf("forward overlapping\n");
		for (i=0;i<length;i++){
			*pdst = *psrc;
			pdst++;
			psrc++;
		}
	}
	else{
	//	printf("backward overlapping\n");
		psrc += length-1;
		pdst += length-1;
		for (i=0;i<length;i++){
			*pdst = *psrc;
			pdst--;
			psrc--;
		}
	}
	return '0';
}

int8_t my_memzero(uint8_t * src, uint32_t length){
	if(src == NULL)
		return 'F';
	uint32_t i;
	for(i = 0;i < length;i ++)
		*(src + i) = '0';
	return '0';
}
 
int8_t my_reverse(uint8_t * str, uint32_t length){
        uint8_t temp;
        uint32_t i=0;
        if (str == NULL)
                return 'F';
        while((i) < (length-1-i))
        {
                temp = *(str+i);
                *(str+i) = *(str+length-1-i);
                *(str+length-1-i) = temp;
                i++;
        }
        return '0';
}

/*
int32_t main(){
	uint8_t a1[]="abcd";
	uint8_t a2[10];
	int8_t R;
	uint8_t mode;
	//switch(mode){
	//	case '1': 
	//}
	//R=my_memmove(a1,a2,4);
	//printf("%c | %s",R,a2);
	return 0;
}
*/
