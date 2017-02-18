grammar csce322h0mework01part01;

// rules
flood	: section section (EOF{System.out.println("File Termination");}); 

section : sec block ; 

block	: INIT (game|move) TERM ;

game	: GINIT g_rows GTERM ; 

move	: MINIT m_rows MTERM ; 

g_rows	: row (ROWEND row)*; 

m_rows	: row+; 

row 	: INT (COLON INT)* ; 

sec 	: SEC; 

// tokens
SEC 	: ('@moves'
		| '@game') {System.out.println("Section: " + getText());} 
		;
INIT	: '{' {System.out.println("Section Initiation: " + getText());} ; 
TERM	: '}' {System.out.println("Section Termination: " + getText());} ;
GINIT	: '[' {System.out.println("Game Initiation: " + getText());} ;
GTERM	: ']' {System.out.println("Game Termination: " + getText());} ;
MINIT	: '(' {System.out.println("List Initiation: " + getText());} ;
MTERM	: ')' {System.out.println("List Termination: " + getText());} ;
ROWEND	: ';' {System.out.println("Row Termination: " + getText());} ;
INT 	: [0-9]+ {System.out.println("Number: " + getText());} ;
WS 		: [ \t\n\r]+ -> skip;
COLON	: ':' ;
ERROR 	: ~('{'|'}'|'['|']'|'('|')'|';'|':'|[0-9]|'@'|'m'|'o'|'v'|'e'|'s'|'g'|'a')
		{System.out.println("Abomination: " + getText() + " in line "+ getLine() +"."); System.exit(0);} ;
