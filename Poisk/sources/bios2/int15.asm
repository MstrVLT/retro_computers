;********************************************************
;*                                                      *
;*            AT ����������� ������                     *
;*		 I N T     1 5 				*
;*							*
;********************************************************
;
;-- INT 15 ---------------------------------------------
;							;
; INT_15_SERVICE					;
;							;
;	��� ��������� ������������ ����������� ������
;							;
; ���� 							;
;	AH = C0    - ���������� ������������ �������
;							;
;							;
;-------------------------------------------------------
	ORG	0F859H
INT_15_SERVICE	Proc NEAR
	STI
	CMP	AH,80H				; ����������� ������� ?

INT_15_AT_SERVICE:
;
;------ ���������� �������� ������������
;
	CMP	AH,90H
	JE	INT_15_OK
;------ ����������� ����������� ����������
	CMP	AH,91H
	JE	INT_15_OK
;------ ������� ������������ �������
	CMP	AH,0C0H
	JNE	INT_15_BAD
	PUSH	CS
	POP	ES				; ��������� �� �������
	MOV	BX,Offset C0_TBL	                              
INT_15_OK:
	XOR	AH,AH				; AH=0 - ���������� ������
INT_15_RET:
	RETF	2
INT_15_BAD:
	STC
	MOV	AH,86H
	JMP	short INT_15_RET
INT_15_SERVICE	EndP
;
;------ ��������� ������� ������������
;
C0_TBL		DW	8		; Length of DESC
		DB	0FBH		; Model
		DB	00		; SubModel
		DB	2		; BIOS revision level
		DB	10100000B	; FEATURE :
				; bit 7=1   BIOS use DMA ch 3
				; bit 6=0   One INT ctrl
				; bit 5=1   Real-time Clock present
				; bit 4=1   KBD escape sequence (INT 15)
				;	      called in KBD INT (INT 9)
				; bit 2=1   Extended BIOS data area is allocated
		DB	0,0,0,0

