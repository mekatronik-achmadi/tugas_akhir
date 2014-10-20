#ifndef ROBOT_PAL
#define ROBOT_PAL

#define O1 0
#define O2 1
#define O3 2
#define O4 3
#define O5 4
#define O6 5
#define O7 6
#define O8 7

#define O0 8

#define PORT_PAL GPIOC

#define LEFT_A O1
#define LEFT_B O2
#define LEFT_I L1

#define RIGHT_A O3
#define RIGHT_B O4
#define RIGHT_I L2

void Pal_Setup(void);

void Left_fow(void);
void Left_back(void);

void Right_fow(void);
void Right_back(void);

void Pal_clear(void);

#endif
