//P5.0--STEPA    P5.1--STEPB              P5.2--STEPC              P5.3--STEPD
#include <c8051f020.h>                    // SFR declarations
#include <intrins.h>
// Function PROTOTYPES
void PORT_Init (void);
/*******************************************************
  �������ƣ�      void sleep_ms(WORD count)
  ����������      ��ʱ
       ���룺          WORD count(��Ҫ��ʱ�ĳ���)
       �����          ��
  ȫ�ֱ�����      ��
  ����ģ�飺      _nop_()
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
    /*��Ч���Ź�*/
    WDTCN = 0xde;
    WDTCN = 0xad;
    PORT_Init ();
    SendData=0xff;          /*4����Ȧ����ֹ*/
    while(1)
    /*���������ת*/
    for(k=0;k<10;k++)
	{
        SendData=0x0e;          /*A��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x0c;          /*AB��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x0d;          /*B��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x09;          /*BC��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x0b;          /*C��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x03;          /*CD��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x07;          /*D��ͨ��*/
        P5=SendData;
        sleep_ms(250);
        SendData=0x06;          /*DA��ͨ��*/
        P5=SendData;
        sleep_ms(250);
    } 
} 
