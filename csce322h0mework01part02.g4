grammar csce322h0mework01part02;

@header {import java.util.Arrays;}
@members {
		int moves =0; 
		int players = 0; 
		boolean abomination = false;
		int[] semantics = new int[5];
		}
// rules
flood locals[int[] semantics = new int[5];]
		: ((g_section m_section)|(m_section g_section)) EOF 
				{
					//rule number 2:
					//The number of Moves must be more than three (3) times as 
					//large as the number of players in the Game
					if (moves <= (3 * players)){
						semantics[1]=2; 
						abomination=true;
					}

					//rule number 1:
					//The Game must have 2 to 4 players. 
					if ((players < 2) || (players > 4)){
						semantics[0]=1; 
						abomination=true; 
					} 
					//Objective:
					//Print player count if there are no abominations
					//Else print the abominations
					if (!abomination) System.out.println("This game has " + players + " players.");
					else {
						for (int i=0; i<5; i++){
							if(semantics[i] != 0) System.out.println("Semantic Abomination "+ semantics[i]);
						}
					}

				} ;
g_section : G_SEC '{' g_block '}'; 
m_section : M_SEC '{' m_block '}';
g_block	: '[' rows 
		{
			String[] game_string =  $rows.text.split("[:;]");
			String[] game_rows =  $rows.text.split(";");
			String[][] gameGrid = new String[game_rows.length][game_string.length/game_rows.length];
			//creating another empty grid to check if there are clusters in the data
			String[][] dummyGrid = new String[game_rows.length][game_string.length/game_rows.length];
			for (int i=0; i<game_rows.length; i++){
				for (int j=0; j< game_string.length/game_rows.length ; j++){
					String[] temp = game_rows[i].split(":");
					gameGrid[i][j] = temp[j];
//					System.out.print(gameGrid[i][j] + " ");
				}
//					System.out.println(',');
			}
			//every element is cross-refrenced with all characters up Vs down and right Vs left
			//if an element matches with any other element in the vicinity, then map "x" else leave null.
			for (int i=0; i<game_rows.length; i++){
				for (int j=0; j< (game_string.length/game_rows.length) ; j++){

					if (j< ((game_string.length)/(game_rows.length))-1 ){
						if ( Integer.parseInt(gameGrid[i][j]) == Integer.parseInt(gameGrid[i][j+1])) {
							dummyGrid[i][j] ="x";
							dummyGrid[i][j+1] = "x";
										
						}
					}
					if (i < game_rows.length -1){
						if (Integer.parseInt(gameGrid[i][j]) == Integer.parseInt(gameGrid[i+1][j])) {
							dummyGrid[i][j] ="x";
							dummyGrid[i+1][j] = "x";	
						}
					}
				} 
			}

			//rule number 5  
			for (int i=0; i<game_rows.length; i++){
				for (int j=0; j< game_string.length/game_rows.length ; j++){
					if (dummyGrid[i][j] != "x" ){
						semantics[4] = 5 ;	
						abomination = true ;

					}
				}
			}

			int g_len = game_string.length;
			int[] game_int = new int[g_len];
			for (int i = 0; i < g_len; i++){
				game_int[i] = Integer.parseInt(game_string[i]);
			} 
			Arrays.sort( game_int );
			players = game_int[g_len-1];
			int[] player_positions = new int[players];
			int count=0;
			for (int i=0; i < players; i++) { 
				count =0; 
				for (int j=0; j < g_len; j++) { 
					if(game_int[j] == i+1) { 
						count++; 
					}
				} 
				player_positions[i]=count;
			}
			//rule number 4:
			//Player 1 may not occupy more than 25% of the spaces in the Game .
			if (player_positions[0] > (0.25 * g_len)){ 
				semantics[3] = 4 ;	
				abomination = true ;
			}
		} ']' ;
m_block : '(' row 
		{
			String[] move_string =  $row.text.split("[:;]");
			int m_len = move_string.length;
			int[] move_int = new int[m_len];
			for (int i = 0; i < m_len; i++) {	
				move_int[i] = Integer.parseInt(move_string[i]);
			} 
			int[] m_int = move_int;
			moves = m_len;

			//rule number 3:
			//The Moves must be in descending order
			for (int i = 0; i < m_len - 1; i++){ 
				if (move_int[i] <= move_int[i+1]){
					semantics[2] = 3;	
					abomination=true;	
				}
			}
		}	
		  ')' ;

rows 	: row ';' row ';' row ';' row (';' row)+ ; 
		//must contain more than 4 rows. This is a syntax error.
row 	: INT ':' INT ':' INT ':' INT (':' INT )+ ;
		//must contain more than 4 columns. This is a syntax error.

// tokens
M_SEC 	: '@moves';
G_SEC 	: '@game';
INT 	: [0-9]+ ;
WS 		: [ \t\n\r]+ -> skip;
