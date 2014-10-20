#include "srcconf.h"

void Right_fow(void){
	palSetPad(PORT_PAL,RIGHT_B);
	palClearPad(PORT_PAL,RIGHT_A);
	
	palSetPad(PORT_LED,RIGHT_I);
}

void Right_back(void){
	palSetPad(PORT_PAL,RIGHT_A);
	palClearPad(PORT_PAL,RIGHT_B);
	
	palClearPad(PORT_LED,RIGHT_I);
}

void Left_fow(void){
	palSetPad(PORT_PAL,LEFT_B);
	palClearPad(PORT_PAL,LEFT_A);
	
	palSetPad(PORT_LED,LEFT_I);
}

void Left_back(void){
	palSetPad(PORT_PAL,LEFT_A);
	palClearPad(PORT_PAL,LEFT_B);
	
	palClearPad(PORT_LED,LEFT_I);
}

void Pal_clear(void){
	palClearPad(PORT_PAL,LEFT_A);
	palClearPad(PORT_PAL,LEFT_B);
	palClearPad(PORT_PAL,RIGHT_A);
	palClearPad(PORT_PAL,RIGHT_B);
}

static WORKING_AREA(wa_palTestThread, 128);
static msg_t palTestThread(void *arg) {
  (void)arg;
  
  while(TRUE){
	  Left_back();
	  Right_fow();
	  chThdSleepMilliseconds(1000);
	  
	  Left_fow();
	  Right_back();
	  chThdSleepMilliseconds(1000);
  }
  
  return 0;
}

void Pal_Setup(void){
  palSetPadMode(PORT_PAL,O1,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O2,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O3,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O4,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O5,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O6,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O7,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_PAL,O8,PAL_MODE_OUTPUT_PUSHPULL);
  
  //chThdCreateStatic(wa_palTestThread, sizeof(wa_palTestThread), NORMALPRIO, palTestThread, NULL);
}
