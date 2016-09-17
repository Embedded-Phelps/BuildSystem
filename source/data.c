#include <stdio.h>
#include <stdint.h>

int8_t * my_itoa(int8_t *str, int32_t data, int32_t base){
	if (str == NULL)
		return NULL;
	int32_t pw, temp;
	int8_t * result = str;
	if((base == 10)&&(data < 0)){
		*str++ = '-';
		data = 0 - data;
		temp = data;
	}
	temp = data;
	for(pw=1;temp>base;temp/=base)
		pw *=base;
	for(;pw>0;pw/=base){
		temp = data/pw;
		if (temp>9)
			temp += 7;
		*str++ = '0'+temp;
		data %= pw;
	}
	*str = '\0';
	return result;
}

int32_t my_atoi(int8_t *str){
	if (str == NULL)
		return 0;
	uint8_t neg=1;
	uint32_t n;
	while (*str == ' ')			//skip spaces
		str ++;
	if ((*str != '-')&&(*str < '0')&&(*str > '9'))
		return 0;
	if (*str == '-'){
		neg = 0;
		str ++;
	}
	for (n=0;((*str > '0')&&(*str < '9'));str++){
		n=10*n+(*str-'0');
	}
	return neg?n:-n;
}

void dump_memory(uint8_t * start, uint32_t length){
	if (start == NULL)
		return;
	uint32_t i;
	for(i = 0;i < length;i ++)
		printf("%c ", *(start+i));
	printf("\n");
}

uint32_t big_to_little(uint32_t data){
	
}

uint32_t little_to_big(uint32_t data){
	data = (data>>24 & 0xff)     | \
	       (data>>8 & 0xff00)    | \
	       (data<<8 & 0xff0000)  | \
	       (data<<24 & 0xff000000);
	return data;
}


uint32_t main(){
	int8_t a[33];
	int32_t b;
	uint8_t mode;
	uint8_t memory[]="123456abcdef";
	uint8_t *p=NULL;
	uint32_t length;
	mode=getchar();
	switch (mode){
		case '1': scanf("%d",&b);
		   	  my_itoa(a,b,10);
		    	  printf("\n itoa: %s \n",a);
		  	  break;
		case'2': scanf("%s",a);
		   	 b=my_atoi(a);
		   	 printf("\n atoi: %d \n", b);
		   	 break;
		case'3': scanf("%d",&length);
			 p=memory;
			 dump_memory(p,length);
			 break;
		case'4': scanf("%x", &b);
			 b=little_to_big(b);
		         printf("\n %x \n",b);
			 break;
		default:;
	}
	return 0;
}
