#include<c8051f020.h>
//����16λ����Ĵ��� 
sfr16 TMR3RL = 0x92;
sfr16 TMR3 = 0x94;
//���峣��
#define SYSCLK 2000000
//ȫ�ֱ�������
unsigned char i = 0xfe; 
void main(void)
{
	WDTCN = 0xde;
	WDTCN = 0xad; //��ֹ���Ź���ʱ��
	XBR2 = 0x40; //ʹ�ܽ��濪��
	P74OUT |= 0x000; //�������
	P4.0 = P5.0; 
	P4.3 = P5.3;
	P4.5 = P5.5;
	P4.7 = P5.7;
 } 
