
#INCLUDE <P16F877A.INC>

#DEFINE BANCO_0 BCF STATUS,RP0
#DEFINE BANCO_1 BSF STATUS,RP0

DATO EQU 0X20

;DP	G	F	E	D	C	B	A
;7	6	5	4	3	2	1	0

;CATODO COMUN
_A_ EQU B'01110111'		;0X77
_E_ EQU B'01111001'		;0X7F
_I_ EQU B'00110000'		;0X30
_O_ EQU B'00111111'		;0X3F
_U_ EQU B'00111110'		;0X3E
_a_ EQU B'01011111'		;0X5F
_e_ EQU B'01111011'		;0X7B
_i_ EQU B'00010000'		;0X10
_o_ EQU B'01011100'		;0X5C
_u_ EQU B'00011100'		;0X1C

;ANODO COMUN
_A EQU B'10001000'		;0X88
_E EQU B'10000110'		;0X80
_I EQU B'11001111'		;0XCF
_O EQU B'11000000'		;0XC0
_U EQU B'11000001'		;0XC1
_a EQU B'10100000'		;0XA0
_e EQU B'10000100'		;0X84
_i EQU B'11101111'		;0XEF
_o EQU B'10100011'		;0XA3
_u EQU B'11100011'		;0XE3

	ORG 0H
	GOTO INICIO
	ORG 5H

INICIO 
	BANCO_1 			;1 PASIS PARA LA RECEPCION DE DATOS MEDIANTE EL PUERTO SERIE
	CLRF TRISB
	BSF TXSTA,BRGH
	MOVLW .64 
	MOVWF SPBRG
	BCF TXSTA,SYNC
	BSF TXSTA,TXEN
	
	BANCO_0
	BSF RCSTA,CREN
	BSF RCSTA,SPEN
	CLRF PORTB

PRINCIPAL
	BTFSS PIR1,RCIF 			;CHECA EL BUFFER DE RECEPCION
	GOTO PRINCIPAL				;SI NO HAY DATO LISTO ESPERA 
	MOVF RCREG,W				; SI HAY DATO LO LEE
	MOVWF DATO
	SUBLW 'A'
	BTFSC STATUS,Z
	GOTO LETRA_A
	MOVF DATO,W
	SUBLW 'E'
	BTFSC STATUS,Z
	GOTO LETRA_E
	MOVF DATO,W
	SUBLW 'I'
	BTFSC STATUS,Z
	GOTO LETRA_I
	MOVF DATO,W
	SUBLW 'O'
	BTFSC STATUS,Z
	GOTO LETRA_O
	MOVF DATO,W
	SUBLW 'U'
	BTFSC STATUS,Z
	GOTO LETRA_U
	MOVF DATO,W
	SUBLW 'a'
	BTFSC STATUS,Z
	GOTO LETRA_a
	MOVF DATO,W
	SUBLW 'e'
	BTFSC STATUS,Z
	GOTO LETRA_e
	MOVF DATO,W
	SUBLW 'i'
	BTFSC STATUS,Z
	GOTO LETRA_i
	MOVF DATO,W
	SUBLW 'O'
	BTFSC STATUS,Z
	GOTO LETRA_o
	MOVF DATO,W
	SUBLW 'u'
	BTFSC STATUS,Z
	GOTO LETRA_u
	GOTO PRINCIPAL

LETRA_A						;CARGA EN W LA CONSTANTE CORRESONDIENTE
	MOVLW _A_
	GOTO ENVIA

LETRA_E
	MOVLW _E_
	GOTO ENVIA

LETRA_I
	MOVLW _I_
	GOTO ENVIA

LETRA_O
	MOVLW _O_
	GOTO ENVIA

LETRA_U
	MOVLW _U_
	GOTO ENVIA

LETRA_a
	MOVLW _a_
	GOTO ENVIA

LETRA_e
	MOVLW _e_
	GOTO ENVIA

LETRA_i
	MOVLW _i_
	GOTO ENVIA

LETRA_o
	MOVLW _o_
	GOTO ENVIA

LETRA_u
	MOVLW _u_
	GOTO ENVIA
	
ENVIA 
	MOVWF PORTB
	GOTO PRINCIPAL

	END