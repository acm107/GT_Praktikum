;************ (C) COPYRIGHT HAW-Hamburg **************
;* File Name          : main.s
;* Author             : Ehsan Sajadi
;* Author             : Faissal Farid	
;* Version            : V1.0
;* Date               : 08.11.2018
;* Description        : -
;*****************************************************
;----------Beginn der globalen Daten----------
	AREA MyData, DATA, align = 4		

DataList		DCD 35,-1,12,-4096,511,101,-3,-5,0,65
;Soll			DCD -4096,-5,-3,-1,0,12,35,65,101,511
DataListEnd		DCD	0
				GLOBAL DataList
				GLOBAL DataListEnd					
;***********************************************
;* Beginn des Programms *
;************************************************
   AREA MyCode, CODE, READONLY, ALIGN = 4
		
                EXPORT main 
main            PROC
               
			    mov	  r0,#1							; Setzen: Getaucht <- 1(ja)
WHILE_01		teq	  r0,#1							; Solange Getaucht == 1	, Z wird 1(Z==1)	
				bne   ENDWHILE_01					; Spring wenn Flag Z == 0
DO_1												;
				mov	  r0,#0							; Getaucht <- 0(Nein)
				ldr   r1,=DataList					;
				ldr   r4,=DataListEnd				; 0x20000038 
				sub   r4,#4							; damit die adresse der Ende auf letztem Wert sein
WHILE_02											;
				ldr   r2,[r1]						; Zeiger auf den ersten Wert(aktuelle Wert)
				ldr	  r3,[r1,#4]					; Folgender Wert
				teq   r1,r4							; vergleich r1 und r2 falls gleich setze Z==1
				beq	  WHILE_01						; spring wenn Flag Z ==1
IF_1			cmp	  r2,r3							; Vergleich die beiden Werte (falls r1 < r3 ist, spring ENDIF_1)
				ble	  ENDIF_1						; falls r1 < r3 ist, spring ENDIF_1
THEN_1			str   r2,[r1,#4]					; Schreib aktuelle Wert in r1 nach der Länge 4
				str	  r3,[r1]						; Schreib nachfolger Wert in r1 
				mov   r0,#1							; Getaucht == 1			
ENDIF_1												;
				add   r1,#4							; Zeiger(aktueller Wert) auf dem nachfolger
				b     WHILE_02						; Spring auf WHILE_02					
ENDWHILE_02											; End der WhlieSchleife_2								
ENDWHILE_01											; End der WhlieSchleife_1
forever         b   forever                         
                ENDP
				ALIGN 4
                END