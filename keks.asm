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
delay
	goto stage4
begin
PORTA	equ 0x05
PORTÂ	equ 0x06
	movlw 0x07
	tris PORTÂ
	movlw 0x00
	tris PORTA
	goto stage0
	end