grammar csce322h0mework01part01;

// tokens
SEC 	: '@moves'
		| '@game'
		;
INIT	: '{' ;
TERM	: '}' ;
GINIT	: '[' ;
GTERM	: ']' ;
MINIT	: '(' ;
MTERM	: ')' ;
ROWEND	: ';' ;
INT 	: [0-9]+ ;
WS 		: [ \t\n\r]+ -> skip;


// rules
flood	: section section (EOF{System.out.println("File Termination");});
section : SEC{System.out.println("Section: "+ $SEC.text);} block ;
block	: INIT{System.out.println("Section Initiation: "+ $INIT.text);} (game|move) (TERM{System.out.println("Section Termination: "+ $TERM.text);}) 
			;
game	: (GINIT{System.out.println("Game Initiation: "+ $GINIT.text);}) g_rows (GTERM{System.out.println("Game Termination: "+ $GTERM.text);}) ;
move	: (MINIT{System.out.println("List Initiation: "+ $MINIT.text);}) m_rows (MTERM{System.out.println("List Termination: "+ $MTERM.text);}) ;
g_rows	: row ((ROWEND{System.out.println("Row Termination: "+ $ROWEND.text);}) row)*;
m_rows	: row+;
row 	: (INT{System.out.println("Number: "+ $INT.text);}) (':' (INT{System.out.println("Number: "+ $INT.text);}))* ;

			