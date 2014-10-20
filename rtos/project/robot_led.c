#include "srcconf.h"

static WORKING_AREA(wa_ledThread, 128);
static msg_t ledThread(void *arg) {
  (void)arg;
  
  while(TRUE){
	  chThdSleepMilliseconds(500);
	  palTogglePad(PORT_LED,L0); 
  }
  
  return 0;
}

static WORKING_AREA(wa_ledTestThread, 128);
static msg_t ledTestThread(void *arg) {
  (void)arg;
  
  while(TRUE){
	  chThdSleepMilliseconds(1000);
	  palSetPad(PORT_LED,L1);
	  palSetPad(PORT_LED,L2);
	  palSetPad(PORT_LED,L3);
	  palSetPad(PORT_LED,L4);
	  palSetPad(PORT_LED,L5);
	  palSetPad(PORT_LED,L6);
	  palSetPad(PORT_LED,L7);
	  palSetPad(PORT_LED,L8);
	  
	  chThdSleepMilliseconds(1000);
	  palClearPad(PORT_LED,L1);
	  palClearPad(PORT_LED,L2);
	  palClearPad(PORT_LED,L3);
	  palClearPad(PORT_LED,L4);
	  palClearPad(PORT_LED,L5);
	  palClearPad(PORT_LED,L6);
	  palClearPad(PORT_LED,L7);
	  palClearPad(PORT_LED,L8);
  }
  
  return 0;
}

void Led_Setup(void){
  palSetPadMode(PORT_LED,L0,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L1,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L2,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L3,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L4,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L5,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L6,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L7,PAL_MODE_OUTPUT_PUSHPULL);
  palSetPadMode(PORT_LED,L8,PAL_MODE_OUTPUT_PUSHPULL);
  
  palSetPad(PORT_LED,L0);
  palSetPad(PORT_LED,L1);
  palSetPad(PORT_LED,L2);
  palSetPad(PORT_LED,L3);
  palSetPad(PORT_LED,L4);
  palSetPad(PORT_LED,L5);
  palSetPad(PORT_LED,L6);
  palSetPad(PORT_LED,L7);
  palSetPad(PORT_LED,L8);
  
  chThdCreateStatic(wa_ledThread, sizeof(wa_ledThread), NORMALPRIO, ledThread, NULL);
  //chThdCreateStatic(wa_ledTestThread, sizeof(wa_ledTestThread), NORMALPRIO, ledTestThread, NULL);
}
