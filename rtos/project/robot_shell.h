#ifndef ROBOT_SHELL
#define ROBOT_SHELL

#define SHELL_WA_SIZE   THD_WA_SIZE(2048)
#define TEST_WA_SIZE    THD_WA_SIZE(256)

#define STOP		0
#define FOWARD		1
#define BACKWARD	2
#define RIGHT		3
#define LEFT		4

void Serial_Setup(void);
void Shell_Setup(void);

#endif
