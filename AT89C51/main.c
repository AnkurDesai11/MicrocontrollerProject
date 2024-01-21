#include <REGX51.h>
sbit rs=P3^0;
sbit rw=P3^1;
sbit en=P3^2;
sbit rd=P3^7;
sbit wr=P3^6;
sbit intr=P3^3;
sbit buzzer=P2^0;
sbit ledgreen=P2^1;
sbit ledred=P2^2;
//sbit cs=P2^6;
void lcdstart();
void commandLine(unsigned int a);
void dataLine(unsigned int b);
void display(unsigned int c);
void delay(unsigned int c);
unsigned char adc(),reading,value;
int gasflag;
void commandLine(unsigned int a)
{
   P1=a;
   rs=0;
   rw=0;
   en=1;
   delay(1);
   en=0;
}
void lcdstart()
{
   commandLine(0x38);
   commandLine(0x0e);
   commandLine(0x06);
   commandLine(0x01);
   commandLine(0x80);
}
void dataLine(unsigned int b)
{
   P1=b;
   rs=1;
   rw=0;
   en=1;
   delay(1);
   en=0;
}
void display(unsigned char *p)
{
   while(*p)
      dataLine(*p++);
}
unsigned char adc()
{
   //cs=0;
   wr=0;
   rd=1;
	
   wr=1;
   while(intr==1);
   //cs=0;
   rd=0;
   value=P0;
   rd=1;
   //cs=1;
   return value;
}
void delay(unsigned int c)
{
   int i;
   int j;
   for(i=0;i<c;i++)
   {
      for(j=0;j<1250;j++);
   }
}
void main()
{
   lcdstart();
	
   
	P0=0xFF;
	//P2=0x00;
   while(1)
   {
      display("GAS (ppm) = ");
	  reading=adc();
	  while(intr==1);
      commandLine(0x8c);
      dataLine((reading/100)+48);
      dataLine(((reading/10)%10)+48);
      dataLine((reading%10)+48);
      commandLine(0xc0);
	  
      if(reading>75)
      {
	 display("GAS, VALVE OFF");
	 
	 buzzer=1;
	 ledred=1;
	 ledgreen=0;
	 delay(100);
	 lcdstart();
	 buzzer=0;
	 gasflag=1;
	 
	 //break;
      }
      else
      {
		  if(gasflag==0)
		  {
			  
			  display("NO GAS VALVE ON ");
			  delay(1);
	          ledred=0;
	          ledgreen=1;
		  }
		 else
		 {
			 display("VALVE OFF");
			 delay(100);
			 commandLine(0x80);
			 display("GAS SENSED BEFOR");
			 commandLine(0xc0);
			 display("INITIATE REPAIRS");
			 buzzer=1;
			 ledred=1;
	         ledgreen=0;
			 delay(100);
			 lcdstart();
			 ledred=0;
		 }
		  
      }
   }
}