	PROCESSOR PIC16F877
	errorlevel -302
	__config _WDT_OFF
#include <p16f877.inc>
	org 0x000
	movlw 0x20
	movwf STATUS
	clrw
	movwf PCLATH
	movlw 0x07
	movwf ADCON1
	banksel ADCON0
	clrf PORTA
	clrf PORTÂ
	movlw 0x02	;íàñòðîéêà option(0x07 - 1:256, 0x00 - 1:2, 0x01 - 1:4 ...)
	option
	clrf 0x01
	goto begin
stage0
	bcf PORTA,0x03
	bcf PORTA,0x02
	bcf PORTA,0x01
	bcf PORTA,0x00
	goto stage1
stage1
	bsf PORTA,0x01
	goto scan0
stage2
	bcf PORTA,0x01
	bsf PORTA,0x02
	goto scan1
stage3
	bcf PORTA,0x02
	bsf PORTA,0x00
	goto delay
stage4
	bcf PORTA,0x00
	bsf PORTA,0x01
	bsf PORTA,0x02
	goto scan2
stage5
	bcf PORTA,0x01
	bcf PORTA,0x02
	bsf PORTA,0x03
	goto scan3
scan0
	btfsc PORTB,0x00
	goto stage2
	goto stage1
scan1
	btfsc PORTB,0x01
	goto stage3
	goto stage2
scan2
	btfsc PORTB,0x02
	goto stage5
	goto stage4
scan3
	btfss PORTB,0x00
	goto stage0
	goto stage5
delay		;çàäåðæêà
	clrf 0x01
	movlw 0xFF
	movwf 0x78
	movlw 0x31
	movwf 0x79
	goto c1
c1
	movlw 0xff
	subwf 0x01,0
	btfss STATUS,0x02
	goto c1
	goto d1
d1
	decfsz 0x79,1
	goto c1
	goto c2
c2
	movlw 0xff
	subwf 0x01,0
	btfss STATUS,0x02
	goto c2
	goto d2
d2
	decfsz 0x78,1
	goto c2
	goto stage4
begin
PORTA	equ 0x05
PORTÂ	equ 0x06
TMR0	equ 0x01
STATUS	equ 0x03
	movlw 0xFF
	movwf OPTION_REG
	movlw 0x07
	tris PORTÂ
	movlw 0x00
	tris PORTA
	goto stage0
	end