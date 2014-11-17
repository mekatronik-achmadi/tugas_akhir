#include "srcconf.h"
 
uint16_t dir;
uint16_t delay=250;

Thread *shelltp = NULL;

static void cmd_test(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  
  chprintf(chp,"serial ok !!\n\r");
  return;
}

static void cmd_foward(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  dir=FOWARD;
  chThdSleepMilliseconds(delay+150);
  dir=STOP;
  return;
}

static void cmd_backward(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  dir=BACKWARD;
  chThdSleepMilliseconds(delay+150);
  dir=STOP;
  return;
}

static void cmd_right(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  dir=RIGHT;
  chThdSleepMilliseconds(delay-150);
  dir=STOP;
  return;
}

static void cmd_left(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  dir=LEFT;
  chThdSleepMilliseconds(delay-150);
  dir=STOP;
  return;
}

static void cmd_stop(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  dir=STOP;
  return;
}

static void cmd_booted(BaseSequentialStream *chp, int argc, char *argv[]) {
  (void)argv;
  
  if(argc>0){
    chprintf(chp,"bad commands\n\r");
    return;
  }
  palTogglePad(PORT_LED,L3);
  return;
}

static const ShellCommand commands[] = {
  {"test",cmd_test},
  {"foward",cmd_foward},
  {"backward",cmd_backward},
  {"right",cmd_right},
  {"left",cmd_left},
  {"stop",cmd_stop},
  {"booted",cmd_booted},
  {NULL, NULL}
};

static const ShellConfig shell_cfg1 = {
  (BaseSequentialStream *)&SD1,
  commands
};

void Serial_Setup(void){
  palSetPadMode(GPIOA,9,16);
  palSetPadMode(GPIOA,10,2);
  sdStart(&SD1,NULL);
  shellInit();
}

void Shell_Setup(void){
    if (!shelltp){
      shelltp = shellCreate(&shell_cfg1, SHELL_WA_SIZE, NORMALPRIO);} /* create shell tread */
    else if (chThdTerminated(shelltp)) {
      chThdRelease(shelltp);    /* Recovers memory of the previous shell.   */
      shelltp = NULL;           /* Triggers spawning of a new shell.        */
    }
}
