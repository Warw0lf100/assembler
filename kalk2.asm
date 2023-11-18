ORG 800H  
	 LXI H,WSTEP1  
	 RST 3  
	 LXI H,WSTEP2  
	 RST 3  
	 LXI H,LICZBA1  
	 RST 3  
	 RST 5  
	 MOV B,D  
	 MOV C,E  
SKOK 	 LXI H,ZNAK  
	 RST 3  
	 RST 2  
	 CPI '+'  
	 JZ DODAJ  
	 CPI '~'  
	 JZ NEG  
	 CPI '-'  
	 JZ ODEJM  
	 JMP SKOK  
DODAJ 	 LXI H,LICZBA2  
	 RST 3  
	 RST 5  
	 MOV H,D  
	 MOV L,E  
	 DAD B  
	 MOV D,H  
	 MOV E,L  
	 JNC WYN  
	 JMP WYNDOD  
NEG 	 MOV A,C  
	 CMA  
	 MOV E,A  
	 MOV A,B  
	 CMA  
	 MOV D,A  
	 JMP WYN  
ODEJM 	 LXI H,LICZBA2  
	 RST 3  
	 RST 5  
	 MOV A,D  
	 CMA  
	 MOV D,A  
	 MOV A,E  
	 CMA  
	 MOV E,A  
	 MOV H,B  
	 MOV L,C  
	 DAD D  
	 JNC WYNODE  
	 LXI B,0001H  
	 DAD B  
	 MOV D,H  
	 MOV E,L  
	 JNC WYN  
	 JMP WYNDOD  
WYN 	 LXI H,WYNIK  
	 RST 3  
	 MOV A,D  
	 RST 4  
	 MOV A,E  
	 RST 4  
	 HLT  
WYNDOD 	 LXI H,WYNIK  
	 RST 3  
	 MVI A,1H  
	 RST 4  
	 MOV A,D  
	 RST 4  
	 MOV A,E  
	 RST 4  
	 HLT  
WYNODE 	 MOV A,H  
	 CMA  
	 MOV D,A  
	 MOV A,L  
	 CMA  
	 MOV E,A  
	 LXI H,WYNIK  
	 RST 3  
	 MVI A,00H  
	 CMP D  
	 JNZ WYNOD1  
	 CMP E  
	 JNZ WYNOD1  
	 JZ WYNOD2  
WYNOD1 	 MVI A,'-'  
	 RST 1  
	 MOV A,D  
	 RST 4  
	 MOV A,E  
	 RST 4  
	 HLT  
WYNOD2 	 MOV A,D  
	 RST 4  
	 MOV A,E  
	 RST 4  
	 HLT  
WSTEP1 	 DB  'Witamy w kalkulatorze',10,13,'@'                       
WSTEP2 	 DB  'Kalkulator wykonuje operacje +, -, ~@'                       
LICZBA1 	 DB  10,13,'Podaj pierwsza liczbe: @'                    
LICZBA2 	 DB  10,13,'Podaj druga liczbe: @'                    
ZNAK 	 DB  10,13,'Podaj znak operacji: @'                     
WYNIK 	 DB  10,13,'Oto twoj wynik: @'                       
