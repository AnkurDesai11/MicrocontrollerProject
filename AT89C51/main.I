
#line 1 "..\main.c" /0
  
#line 1 "F:\Kiel Microvision\C51\BIN\..\INC\Atmel\REGX51.h" /0






 
 
 
 
 


 
 sfr P0      = 0x80;
 sfr SP      = 0x81;
 sfr DPL     = 0x82;
 sfr DPH     = 0x83;
 sfr PCON    = 0x87;
 sfr TCON    = 0x88;
 sfr TMOD    = 0x89;
 sfr TL0     = 0x8A;
 sfr TL1     = 0x8B;
 sfr TH0     = 0x8C;
 sfr TH1     = 0x8D;
 sfr P1      = 0x90;
 sfr SCON    = 0x98;
 sfr SBUF    = 0x99;
 sfr P2      = 0xA0;
 sfr IE      = 0xA8;
 sfr P3      = 0xB0;
 sfr IP      = 0xB8;
 sfr PSW     = 0xD0;
 sfr ACC     = 0xE0;
 sfr B       = 0xF0;
 


 
 sbit P0_0 = 0x80;
 sbit P0_1 = 0x81;
 sbit P0_2 = 0x82;
 sbit P0_3 = 0x83;
 sbit P0_4 = 0x84;
 sbit P0_5 = 0x85;
 sbit P0_6 = 0x86;
 sbit P0_7 = 0x87;
 


 
 
 
 
 
 
 
 
 
 
 


 
 sbit IT0  = 0x88;
 sbit IE0  = 0x89;
 sbit IT1  = 0x8A;
 sbit IE1  = 0x8B;
 sbit TR0  = 0x8C;
 sbit TF0  = 0x8D;
 sbit TR1  = 0x8E;
 sbit TF1  = 0x8F;
 


 
 
 
 
 
 
 
 
 
 
 
 
 


 
 sbit P1_0 = 0x90;
 sbit P1_1 = 0x91;
 sbit P1_2 = 0x92;
 sbit P1_3 = 0x93;
 sbit P1_4 = 0x94;
 sbit P1_5 = 0x95;
 sbit P1_6 = 0x96;
 sbit P1_7 = 0x97;
 


 
 sbit RI   = 0x98;
 sbit TI   = 0x99;
 sbit RB8  = 0x9A;
 sbit TB8  = 0x9B;
 sbit REN  = 0x9C;
 sbit SM2  = 0x9D;
 sbit SM1  = 0x9E;
 sbit SM0  = 0x9F;
 


 
 sbit P2_0 = 0xA0;
 sbit P2_1 = 0xA1;
 sbit P2_2 = 0xA2;
 sbit P2_3 = 0xA3;
 sbit P2_4 = 0xA4;
 sbit P2_5 = 0xA5;
 sbit P2_6 = 0xA6;
 sbit P2_7 = 0xA7;
 


 
 sbit EX0  = 0xA8;        
 sbit ET0  = 0xA9;        
 sbit EX1  = 0xAA;        
 sbit ET1  = 0xAB;        
 sbit ES   = 0xAC;        
 sbit ET2  = 0xAD;        
 
 sbit EA   = 0xAF;        
 


 
 sbit P3_0 = 0xB0;
 sbit P3_1 = 0xB1;
 sbit P3_2 = 0xB2;
 sbit P3_3 = 0xB3;
 sbit P3_4 = 0xB4;
 sbit P3_5 = 0xB5;
 sbit P3_6 = 0xB6;
 sbit P3_7 = 0xB7;
 
 sbit RXD  = 0xB0;        
 sbit TXD  = 0xB1;        
 sbit INT0 = 0xB2;        
 sbit INT1 = 0xB3;        
 sbit T0   = 0xB4;        
 sbit T1   = 0xB5;        
 sbit WR   = 0xB6;        
 sbit RD   = 0xB7;        
 


 
 sbit PX0  = 0xB8;
 sbit PT0  = 0xB9;
 sbit PX1  = 0xBA;
 sbit PT1  = 0xBB;
 sbit PS   = 0xBC;
 sbit PT2  = 0xBD;
 


 
 sbit P    = 0xD0;
 sbit F1   = 0xD1;
 sbit OV   = 0xD2;
 sbit RS0  = 0xD3;
 sbit RS1  = 0xD4;
 sbit F0   = 0xD5;
 sbit AC   = 0xD6;
 sbit CY   = 0xD7;
 



 
 
 
 
 
 
 
 
 
 
#line 1 "..\main.c" /0
 
 sbit rs=P3^0;
 sbit rw=P3^1;
 sbit en=P3^2;
 sbit rd=P3^7;
 sbit wr=P3^6;
 sbit intr=P3^3;
 sbit buzzer=P2^0;
 sbit ledgreen=P2^1;
 sbit ledred=P2^2;
 
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
 
 wr=0;
 rd=1;
 
 wr=1;
 while(intr==1);
 
 rd=0;
 value=P0;
 rd=1;
 
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
