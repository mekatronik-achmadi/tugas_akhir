#include "srcconf.h"

uint16_t loop;
uint16_t value=50;
extern uint16_t dir;

static void gpt3cb(GPTDriver *gptp) {
  (void)gptp;
  
  loop++;
  
  if(loop==value){
    Pal_clear(); 
  }
  
  if(loop==100){
    
    loop=0;
    
    if(dir==FOWARD){
      Right_fow();
      Left_fow();
      palClearPad(PORT_LED,RIGHT_I);
      palClearPad(PORT_LED,LEFT_I);
    }
    else if(dir==BACKWARD){
      Right_back();
      Left_back();
      palClearPad(PORT_LED,RIGHT_I);
      palClearPad(PORT_LED,LEFT_I);
    }  
    else if(dir==RIGHT){
      Right_back();
      Left_fow();
      palClearPad(PORT_LED,RIGHT_I);
      palSetPad(PORT_LED,LEFT_I);
    }  
    else if(dir==LEFT){
      Right_fow();
      Left_back();
      palSetPad(PORT_LED,RIGHT_I);
      palClearPad(PORT_LED,LEFT_I);
    }
    else if(dir==STOP){
      Pal_clear();
      palSetPad(PORT_LED,RIGHT_I);
      palSetPad(PORT_LED,LEFT_I);
    }
    
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
