/****************************************************
* data.c
*
* author: ShuTing Guo
*
* date: 9/18/2016
*
* Description: provided data-manupulation functions 
*              including integer to string, string to
*              integer, memory dump, big-endian/little
*              endian convertion.
*
*****************************************************/

#include <stdio.h>
#include <stdint.h>

/****************************************************
* @name: my_itoa
*
* @description: Converts a integer to an ASCII string
*
* @param: str -- pointer to the string
*         data -- the integer to be converted
*         base -- base of the integer
* 
* @return: pointer to the string
*/

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

/****************************************************
* @name: my_atoi
*
* @description: Converts an ASCII string to an integer
*
* @param: str -- pointer to the string
* 
* @return: the integer converted from the string
*/

int32_t my_atoi(int8_t *str){
    if (str == NULL)
        return 0;
    uint8_t neg=1;
    uint32_t n;
    while (*str == ' ')			//skip spaces
        str ++;
    if ((*str != '-')&&((*str < '0')||(*str > '9')))
        return 0;
    if (*str == '-'){
        neg = 0;
        str ++;
    }
    for (n=0;((*str >= '0')&&(*str <= '9'));str++){
        n=10*n+(*str-'0');
    }
    return neg?n:-n;
}

/****************************************************
* @name: dump_memory
*
* @description: print the hex output of memory locations
*
* @param: start -- pointer to the first memory location
*         length -- bytes of memory to print
*/

void dump_memory(uint8_t * start, uint32_t length){
    if (start == NULL)
        return;
    uint32_t i;
    for(i = 0;i < length;i ++)
        printf("%x", *(start+i));
    printf("\n");
}

/****************************************************
* @name: big_to_little
*
* @description: Converts data types from big-endian 
*               representation to little-endian
*               
* @param: data -- the data to be converted
* 
* @return: the data converted
*/

uint32_t big_to_little(uint32_t data){
     data = (data>>24 & 0xff)     | \
            (data>>8 & 0xff00)    | \
            (data<<8 & 0xff0000)  | \
            (data<<24 & 0xff000000);
     return data;
}

/****************************************************
* @name: little_to_big
*
* @description: Converts data types from little-endian 
*               representation to big-endian
*               
* @param: data -- the data to be converted
* 
* @return: the data converted
*/

uint32_t little_to_big(uint32_t data){
    data = (data>>24 & 0xff)     | \
	   (data>>8 & 0xff00)    | \
	   (data<<8 & 0xff0000)  | \
	   (data<<24 & 0xff000000);
    return data;
}

