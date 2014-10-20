#include "srcconf.h"

uint16_t loop;
uint16_t value=75;

static void gpt3cb(GPTDriver *gptp) {
  (void)gptp;
  
  loop++;
  
  if(loop==value){
	Right_fow();
	Left_fow();  
  }
  
  if(loop==100){
	loop=0;
	Pal_clear();  
  }
  
  chSysLockFromIsr();
  gptStartOneShotI(&GPTD3, 10);
  chSysUnlockFromIsr();
}

static const GPTConfig gpt3cfg = {
  F_GPT,    /* 10kHz timer clock.*/
  gpt3cb,   /* Timer callback.*/
  0
};

void Gpt_Setup(void){
  gptStart(&GPTD3, &gpt3cfg);
  gptStartOneShot(&GPTD3, 10);
}
