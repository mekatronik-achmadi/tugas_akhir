#include "stm32f10x_conf.h"

struct __FILE {
  int handle; 
};

FILE __stdout;
FILE __stdin;

int SendChar (int ch){

  while (!(USART1->SR & USART_FLAG_TXE));
  USART1->DR = (ch & 0x1FF);

  return (ch);
}

int ReadChar (void){

  while (!(USART1->SR & USART_FLAG_RXNE));

  return ((int)(USART1->DR & 0x1FF));
}

int fputc (int ch, FILE *f){ 
  USART_SendData(USART1, (uint8_t) ch);

  while (USART_GetFlagStatus(USART1, USART_FLAG_TC) == RESET)
  {
	}

  return ch;
}

int fgetc(FILE *f){

	return (ReadChar());
}

void _ttywrch(int ch){

 SendChar (ch);
}

int _ferror(FILE *f) {
                     
  return EOF;
}

void _sys_exit(int return_code) {

 label:  goto label; 
}