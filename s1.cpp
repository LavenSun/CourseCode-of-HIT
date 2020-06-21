#include<c8051f020.h>
//定义16位特殊寄存器 
sfr16 TMR3RL = 0x92;
sfr16 TMR3 = 0x94;
//定义常量
#define SYSCLK 2000000
//全局变量定义
unsigned char i = 0xfe; 
void main(void)
{
	WDTCN = 0xde;
	WDTCN = 0xad; //禁止看门狗定时器
	XBR2 = 0x40; //使能交叉开关
	P74OUT |= 0x000; //推挽输出
	P4.0 = P5.0; 
	P4.3 = P5.3;
	P4.5 = P5.5;
	P4.7 = P5.7;
 } 
