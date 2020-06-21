//P5.0--STEPA    P5.1--STEPB              P5.2--STEPC              P5.3--STEPD
#include <c8051f020.h>                    // SFR declarations
#include <intrins.h>
// Function PROTOTYPES
void PORT_Init (void);
/*******************************************************
  函数名称：      void sleep_ms(WORD count)
  功能描述：      延时
       输入：          WORD count(所要延时的长度)
       输出：          无
  全局变量：      无
  调用模块：      _nop_()
/****************************************************/ 
void sleep_ms(unsigned char count)
{
    unsigned char ii,jj;
    for(ii=0;ii<count;ii++)
    {
        for(jj=0;jj<250;jj++)
             _nop_();                      
    }   
}
// MAIN Routine
  
void main (void) 
{
    unsigned char k;
    unsigned char SendData;
    /*无效看门狗*/
    WDTCN = 0xde;
    WDTCN = 0xad;
    PORT_Init ();
    SendData=0xff;          /*4相线圈都截止*/
    while(1)
    /*步进电机正转*/
    for(k=0;k<10;k++)
	{
        SendData=0x0e;          /*A相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x0c;          /*AB相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x0d;          /*B相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x09;          /*BC相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x0b;          /*C相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x03;          /*CD相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x07;          /*D相通电*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x06;          /*DA相通电*/
        P5=SendData;
        sleep_ms(250);
    } 
} 
