;WELECOM TO AIR HOCKEY GAME 
;DATE 7 JAN 2021
;AUTHER ESLAM EL HEFNY
;VER 1.0
include MACRO.INC
.MODEL HUGE
.STACK 128
.DATA
	;=================================================== DATA SECTION =============================================================

	;**************************************************** HELLO SCREEN DATA ******************************************************
    
	HelloScreenWidth      EQU 301
	HelloScreenHeight     EQU 200
	HelloScreenFilename   DB  '102.bin', 0
	HelloScreenFilehandle DW  ?
	HelloScreenData       DB  HelloScreenWidth*HelloScreenHeight dup(0)

	;*****************************************************************************************************************************

	;*************************************************color codes  ****************************************************************
	RED                   EQU 04h
	WHITE                 EQU 0fh
	BLACK                 EQU 00h
	YELLOW                EQU 0Eh
	BLUE                  EQU 01h
	Cyan                  EQU 03h
	BROWN                 EQU 06h
	GREEEN                EQU 02H
	LIGHT_RED             EQU 0CH
	light_green           EQU 0ah
	gray                  EQU 07h
	Dark_Gray             EQU 08h
	LIGHT_cyan            EQU 0bh
	;*****************************************************************************************************************************



	;*************************************************payers name ****************************************************************
	name1                 db  30,?, 30 dup('$')
	name2                 db  30,?, 30 dup('$')
	;******************************************************************************************************************************
	msg1                  db  'Please enter Your name:','$'
	msg2                  db  'Please enter second player name:','$'
	msg3                  db  'Press enter key to continue ','$'
	msg5                  db  ':','$'
	msg6                  db  'score2:','$'
	msg8                  db  'GAME OVER','$'
	msg9                  db  ' WINS','$'
	msg10                 db  'game ended','$'
	msg11                 db  'chat mode','$'
	msg12                 db  'wrong','$'
	msg13                 db  'press any key to start','$'
	msg_goal              db  'GOAL','$'
	msg_sec               DB  'second player is ',0ah,0dh,'$'
	;*******************************************screen 3 **********************************************************************
	Screen3_str           DB  '  ',0ah,0d
	                      db  '                                                                     ',0ah,0dh
	                      DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '               *                                                 *   ',0ah,0dh
	                      DB  '               *         **      Air Hockey game       **        *   ',0ah,0dh
	                      DB  '               *                                                 *   ',0ah,0dh
	                      DB  '               *                                                 *   ',0ah,0dh
	                      DB  '               *                                                 *   ',0ah,0dh
	                      DB  '               *          Please enter 1 for game mode           *   ',0ah,0dh
	                      DB  '               *                      Or                         *   ',0ah,0dh
	                      DB  '               *          Please Enter 2 for chat mode           *   ',0ah,0dh
	                      DB  '               *                      or                         *   ',0ah,0dh
	                      DB  '               *          please enter 3  for EXIT               *   ',0ah,0dh
	                      DB  '               *                                                 *   ',0ah,0dh
	                      DB  '               *                                                 *   ',0ah,0dh
	                      DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '$',0ah,0dh

	;******************************************* chat screen **********************************************************************
	          
	chat_str              DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '               *         **      Air Hockey game       **        *   ',0ah,0dh
	                      DB  '               *         **         chat mode          **        *   ',0ah,0dh
	                      DB  '               *         **       to exit press 3      **        *   ',0ah,0dh
	                      DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '$',0ah,0dh
                        
	player2_win_str       DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '               *         **      congratulation        **        *   ',0ah,0dh
	                      DB  '               *         **         PLAYER 2           **        *   ',0ah,0dh
	                      DB  '               *         **      (:    WIN    :)       **        *   ',0ah,0dh
	                      DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '$',0ah,0dh
                        
	player1_win_str       DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '               *         **      congratulation        **        *   ',0ah,0dh
	                      DB  '               *         **         PLAYER 1           **        *   ',0ah,0dh
	                      DB  '               *         **      (:    WIN    :)       **        *   ',0ah,0dh
	                      DB  '               * * * * * * * * * * * * * * * * * * * * * * * * * *   ',0ah,0dh
	                      DB  '$',0ah,0dh

                        
	chat_player1          DB  30,?,30 dup("$"),'$',0ah,0dh
	chat_player2          DB  30,?,30 dup("$"),'$',0ah,0dh
	end_line_str          DB  ' : ','$'
	raw_number            DB  5
	;*********************************************************************************************************************************

	ball_position_x       db  ?
	ball_position_y       db  ?
	color                 db  0
	column                db  0
 
	row1                  dw  90
	row2                  dw  90
	row3                  dw  50
	row4                  dw  50
	row5                  dw  145
	row6                  dw  125
	row7                  dw  50
	;********************************************************************bar******************************
	BAR_LEFT_Y            DW  95d
	
	BAR_RIGHT_Y           DW  95d
	
	BAR_WIDTH             DW  03h
	BAR_HEIGHT            DW  10h
	BAR_SPEED             DW  05h                                                                            	;Y (vertical) velocity of the ba

	;***************************************************************** ball **********************************




	WINDOW_WIDTH          DW  320d                                                                           	;the width of the window (320 pixels)
	WINDOW_HEIGHT         DW  200d                                                                           	;the height of the window (200 pixels)
	WINDOW_BOUNDS         DW  55d
	WINDOW_START_X        DW  05d                                                                            	;variable used to check collisions early
	WINDOW_START_Y        DW  55d                                                                            	;variable used to check collisions early

	TIME_AUX              DB  0                                                                              	;variable used when checking if the time has changed
	
	BALL_X                DW  160d                                                                           	;X position (column) of the ball
	BALL_Y                DW  100d                                                                           	;Y position (line) of the ball
	BALL_SIZE             DW  08h                                                                            	;size of the ball (how many pixels does the ball have in width and height)
	BALL_VELOCITY_X       DW  05h                                                                            	;X (horizontal) velocity of the ball
	BALL_VELOCITY_Y       DW  02h

	BALL_ORIGINAL_X       DW  0A0h
	BALL_ORIGINAL_Y       DW  64h
	;************************************************************* delay ***********************************************
	PREV_TIME             DB  0

	first_time_flag       DB  0
	end_game_flag         DB  0


	;**************************************************************** paddels ****************************************
	PADDLE_LEFT_X         DW  0Ah                                                                            	;current X position of the left paddle
	PADDLE_LEFT_Y         DW  80d                                                                            	;current Y position of the left paddle
	
	PADDLE_RIGHT_X        DW  130h                                                                           	;current X position of the right paddle
	PADDLE_RIGHT_Y        DW  80d                                                                            	;current Y position of the right paddle
	
	PADDLE_WIDTH          DW  05h                                                                            	;default paddle width
	PADDLE_HEIGHT         DW  1Fh                                                                            	;default paddle height
	PADDLE_VELOCITY       DW  05h                                                                            	;default paddle velocity


	;************************************************************** score *************************************************************
	PlayerScore1          DB  '0','$'
	PlayerScore2          DB  '0','$'

.CODE
exit proc near
	                                 clear
	                                 movecursor               0,0
	                                 print_message            msg10
	                                 ret
exit endp
	;****************************************************************** chat function **************************************************************
chat proc near
	                                 CONVERT_TO_TEXT_MODE

	      
	lp:                              
	;***************************************** read char ********************************************************
	                                 movecursor               0,0
	                                 MOV                      AH,0
	                                 INT                      16H
	                                 CMP                      AL,'3'
	                                 jne                      next
	                                 ret
	next:                            movecursor               0,0
	                                 print_message            chat_str

	                                 movecursor               0,raw_number
	                                 print_message            name1+2
	                                 movecursor               10,raw_number
	                                 print_message            end_line_str
	                                 movecursor               13,raw_number
	                                 read_string              chat_player1
	                                 call                     SendStringchat
                   

	;  movecursor               50,raw_number
	;  print_message            name1+2
	;  movecursor               60,raw_number
	;  print_message            end_line_str
	;  movecursor               63,raw_number
	;  print_message            chat_player1+2

	;  mov                      al,raw_number
	;  inc                      al
	;  mov                      raw_number,al

	                                 movecursor               50,raw_number
	                                 print_message            name2+2
	                                 movecursor               60,raw_number
	                                 print_message            end_line_str
	                                 movecursor               63,raw_number
	                                 call                     RecieveStringChat
	                                 print_message            chat_player2+2

	;  movecursor               0,raw_number
	;  print_message            name2+2
	;  movecursor               10,raw_number
	;  print_message            end_line_str
	;  movecursor               13,raw_number
	;  print_message            chat_player2+2
	                                 mov                      al,raw_number
	                                 cmp                      al,20
	                                 jne                      continue
	                                 clear
	                                 mov                      al,5
	                                 mov                      raw_number,al
	                                 jmp                      lp
	continue:                        inc                      al
	                                 mov                      raw_number,al
	                                 jmp                      lp
        





	                                 ret
chat endp
	;

startgame proc near
	; infint_loop:
	; 			 ;DELAY
	; 			 DRAW_BALL
	; 			 jmp infint_loop

	CHECK_TIME:                      
		
	                                 MOV                      AH,2Ch                          	;get the system time
	                                 INT                      21h                             	;CH = hour CL = minute DH = second DL = 1/100 seconds
			
	                                 CMP                      DL,TIME_AUX                     	;is the current time equal to the previous one(TIME_AUX)?
	                                 JE                       CHECK_TIME                      	;if it is the same, check again
	;if it's different, then draw, move, etc.

	                                 MOV                      TIME_AUX,DL
	                                 clear
	                                 CONVERT_TO_GRAPHICS_MODE

	                                 movecursor               5,1
	                                 print_message            name1+2
	                                 movecursor               15,1
	                                 print_message            msg5
						 
	                                 movecursor               17,1
	                                 print_message            PlayerScore1

	                                 movecursor               63,1
	                                 print_message            name2+2

	                                 movecursor               73,1
	                                 print_message            msg5
						 
	                                 movecursor               75,1
	                                 print_message            PlayerScore2
	;  DRAW_PIXEL               10,10,GREEEN
	;    draw_rectangle           10,10,50,50,RED


	;  DrawbarleftP             20,BAR_LEFT_Y,blue
	;  DrawbarrightP            290,BAR_RIGHT_Y,yellow
	                                 Drawbarleftup            5,row3,LIGHT_RED
	                                 Drawbarleftdown          5,row6,LIGHT_RED
	                                 Drawbarrightup           310,row4,light_green
	                                 Drawbarrightdown         310,row6,light_green
	                                 Drawbarup                5,row4,LIGHT_RED
	                                 Drawbarup                160,row4,light_green
	                                 Drawbardown              5,row5,LIGHT_RED
	                                 Drawbardown              160,row5,light_green
	                                 Drawmidlleline           159,row4,YELLOW

	                                 mov                      al,end_game_flag
	                                 cmp                      al,1
	                                 jne                      next_check
	                                 mov                      al,0
	                                 mov                      end_game_flag,al
	                                 ret

	next_check:                      mov                      al,first_time_flag
	                                 cmp                      al,0
	                                 jne                      not_first_time
	                                 movecursor               10,10
	                                 print_message            msg13
	                                 call                     RESET_BALL_POSITION
	                                 CALL                     DRAW_BALL
						
	                                 MOV                      AH,0
	                                 INT                      16H
	                                 inc                      al
	                                 mov                      first_time_flag ,al
	                                 jmp                      CHECK_TIME

	;update time
	;  CALL          CLEAR_SCREEN
	;  call          startgame
	not_first_time:                  call                     MOVE_PADDLES
	                                 CALL                     MOVE_BALL
	                                 CALL                     DRAW_BALL
	                                 CALL                     DRAW_PADDLES
	                                
			
	                                 JMP                      CHECK_TIME
			
	                                 ret



startgame endp
	;****************************************************************** reset ball position ****************************************
RESET_BALL_POSITION PROC NEAR
		
	                                 MOV                      AX,BALL_ORIGINAL_X
	                                 MOV                      BALL_X,AX
		
	                                 MOV                      AX,BALL_ORIGINAL_Y
	                                 MOV                      BALL_Y,AX
		
	                                 RET
RESET_BALL_POSITION ENDP


	;******************************************************************move bar ****************************************
movebar proc near
	                                 MOV                      AH,01h
	                                 INT                      16h
	                                 JZ                       RIGHT_BBAR_MOVE                 	;checks zero flag
		
	;interrupt key pressed
	                                 MOV                      AH,00h
	                                 INT                      16h
	
	;'q'
	                                 CMP                      AL,71h
	                                 jz                       LEFT_BAR_UP
		
	;'a'
	                                 CMP                      AL,61h
	                                 jz                       LEFT_BAR_DOWN
	                                 JMP                      RIGHT_BBAR_MOVE
		
	LEFT_BAR_UP:                     
	                                 MOV                      AX,BAR_SPEED
	                                 SUB                      BAR_LEFT_Y,AX
			
	                                 MOV                      AX,WINDOW_BOUNDS
	                                 CMP                      BAR_LEFT_Y,AX
	                                 JL                       FIX_LEFT_TOP                    	;reach top corner
	                                 JMP                      RIGHT_BBAR_MOVE
			
	FIX_LEFT_TOP:                    
	                                 MOV                      BAR_LEFT_Y,AX
	                                 JMP                      RIGHT_BBAR_MOVE
			
	LEFT_BAR_DOWN:                   
	                                 MOV                      AX,BAR_SPEED
	                                 ADD                      BAR_LEFT_Y,AX
	                                 MOV                      AX,WINDOW_HEIGHT
	                               
	                                 CMP                      BAR_LEFT_Y,AX                   	;reach bottom corner
	                                 JG                       FIX_LEFT_BOTTOM
	                                 JMP                      RIGHT_BBAR_MOVE
			
	FIX_LEFT_BOTTOM:                 
	                                 MOV                      BAR_LEFT_Y,AX
	                                 JMP                      RIGHT_BBAR_MOVE
		
		
	;right paddle movement
	RIGHT_BBAR_MOVE:                 
		
	; 'i'
	                                 CMP                      AL,69h
	                                 jz                       RIGHT_BAR_UP
			
	; 'k'
	                                 CMP                      AL,6Bh
	                                 jz                       RIGHT_BAR_DOWN
	                                 JMP                      EXIT_RIGHT
			

	RIGHT_BAR_UP:                    
	                                 MOV                      AX,BAR_SPEED
	                                 SUB                      BAR_RIGHT_Y,AX
				
	                                 MOV                      AX,WINDOW_BOUNDS
	                                 CMP                      BAR_RIGHT_Y,AX                  	;reach top corner
	                                 JL                       FIX_RIGHT_TOP
	                                 JMP                      EXIT_RIGHT
				
	FIX_RIGHT_TOP:                   
	                                 MOV                      BAR_RIGHT_Y,AX
	                                 JMP                      EXIT_RIGHT
			
	RIGHT_BAR_DOWN:                  
	                                 MOV                      AX,BAR_SPEED
	                                 ADD                      BAR_RIGHT_Y,AX
	                                 MOV                      AX,WINDOW_HEIGHT
	                                 CMP                      BAR_RIGHT_Y,AX                  	;reach bottom corner
	                                 JG                       FIX_RIGHT_BOTTOM
	                                 JMP                      EXIT_RIGHT
				
	FIX_RIGHT_BOTTOM:                
	                                 MOV                      BAR_RIGHT_Y,AX
	                                 JMP                      EXIT_RIGHT
		
	EXIT_RIGHT:                      
		
	                                 RET
		
movebar endp

	;******************************************************ball


DRAW_BALL PROC NEAR
		
	                                 MOV                      CX,BALL_X                       	;set the initial column (X)
	                                 MOV                      DX,BALL_Y                       	;set the initial line (Y)
	DRAW_BALL_HORIZONTAL:            
		
	                                 MOV                      AH,0Ch                          	;set the configuration to writing a pixel
	                                 MOV                      AL,RED                          	;choose white as color
	                                 MOV                      BH,00h                          	;set the page number
	                                 INT                      10h                             	;execute the configuration
			
	                                 INC                      CX                              	;CX = CX + 1
	                                 MOV                      AX,CX                           	;CX - BALL_X > BALL_SIZE (Y -> We go to the next line,N -> We continue to the next column
	                                 SUB                      AX,BALL_X
	                                 CMP                      AX,BALL_SIZE
	                                 JNG                      DRAW_BALL_HORIZONTAL
			
	                                 MOV                      CX,BALL_X                       	;the CX register goes back to the initial column
	                                 INC                      DX                              	;we advance one line
			
	                                 MOV                      AX,DX                           	;DX - BALL_Y > BALL_SIZE (Y -> we exit this procedure,N -> we continue to the next line
	                                 SUB                      AX,BALL_Y
	                                 CMP                      AX,BALL_SIZE
	                                 JNG                      DRAW_BALL_HORIZONTAL
		
	                                 RET
DRAW_BALL ENDP

MOVE_BALL PROC NEAR
		
	                                 MOV                      AX,BALL_VELOCITY_X
	                                 ADD                      BALL_X,AX                       	;move the ball horizontally
		
	                                 MOV                      AX,WINDOW_START_X
	                                 CMP                      BALL_X,AX
	                                 JNL                      M1                              	;BALL_X < 0 + WINDOW_BOUNDS (Y -> collided)
	                                 NEG                      BALL_VELOCITY_X
	                                 ret
	M1:                              MOV                      AX,WINDOW_WIDTH
	                                 SUB                      AX,BALL_SIZE
	                                 SUB                      AX,WINDOW_START_X
	                                 CMP                      BALL_X,AX                       	;BALL_X > WINDOW_WIDTH - BALL_SIZE  - WINDOW_BOUNDS (Y -> collided)
	                                 JNG                      M2
	                                 NEG                      BALL_VELOCITY_X
	                                 ret
	M2:                              MOV                      AX,BALL_VELOCITY_Y
	                                 ADD                      BALL_Y,AX                       	;move the ball vertically
		
	                                 MOV                      AX,WINDOW_START_Y
	                                 CMP                      BALL_Y,AX                       	;BALL_Y < 0 + WINDOW_BOUNDS (Y -> collided)
	                                 JNL                      M3
	                                 NEG                      BALL_VELOCITY_Y
	                                 ret
	M3:                              MOV                      AX,WINDOW_HEIGHT
	                                 SUB                      AX,BALL_SIZE
	                                 SUB                      AX,WINDOW_START_Y
	                                 CMP                      BALL_Y,AX
	                                 JNG                      M4                              	;BALL_Y > WINDOW_HEIGHT - BALL_SIZE - WINDOW_BOUNDS (Y -> collided)
	                                 NEG                      BALL_VELOCITY_Y
	                                 ret


	M4:                              
	;check if any one have a goal
	;check if BALL_X >70+BALL_SIZE BALL_X <125 - BALL_SIZE && BALL_Y =0
		
	                                 MOV                      AX,BALL_X
	;  ADD                      AX,BALL_SIZE
	                                 CMP                      AX,0
	                                 JNG                      AFTER_CHECK_2
	                                 CMP                      AX,10
	                                 JNL                      AFTER_CHECK_2
	                                 MOV                      AX,BALL_Y
	;  ADD                      AX,BALL_SIZE
	                                 CMP                      AX,60
	                                 JNG                      AFTER_CHECK_2
	                                 CMP                      AX,120
	                                 jnl                      AFTER_CHECK_2
	;  clear
	                                 mov                      al,PlayerScore2
	                                 inc                      al
	                                 cmp                      al,'7'
	                                 jne                      continue_player2
	;player 2 win
	                                 clear
	                                 CONVERT_TO_TEXT_MODE
	                                 movecursor               0,10
	                                 print_message            player2_win_str

	                                 mov                      al ,1
	                                 mov                      end_game_flag,1
	                                 MOV                      AL,'0'
	                                 MOV                      PlayerScore1,al
	                                 MOV                      PlayerScore2,al
	;read char
	                                 MOV                      AH,0
	                                 INT                      16H
	                                 ret


	continue_player2:                
	                                 mov                      PlayerScore2,al
		
	                                 mov                      ax , 0
	                                 mov                      first_time_flag,0

	                                 movecursor               140,100
	                                 print_message            msg_goal
	;read char
	                                 MOV                      AH,0
	                                 INT                      16H
	                                 ret
	AFTER_CHECK_2:                   
	;check if any one have a goal
	;check if BALL_X >70+BALL_SIZE BALL_X <125 - BALL_SIZE && BALL_Y =0
		
	                                 MOV                      AX,BALL_X
	;  ADD                      AX,BALL_SIZE
	                                 CMP                      AX,300
	                                 JNG                      AFTER_CHECK_3
	                                 CMP                      AX,320
	                                 JNL                      AFTER_CHECK_3
	                                 MOV                      AX,BALL_Y
	;  ADD                      AX,BALL_SIZE
	                                 CMP                      AX,60
	                                 JNG                      AFTER_CHECK_3
	                                 CMP                      AX,120
	                                 jnl                      AFTER_CHECK_3
	;  clear
	                                 mov                      al,PlayerScore1

	                                 inc                      al
	                                 cmp                      al,'7'
	                                 jne                      continue_player1
	;player 2 win
	                                 clear
	                                 CONVERT_TO_TEXT_MODE
	                                 movecursor               0,10
	                                 print_message            player1_win_str

	                                 mov                      al ,1
	                                 mov                      end_game_flag,1
	                                 MOV                      AL,'0'
	                                 MOV                      PlayerScore1,al
	                                 MOV                      PlayerScore2,al
	;read char
	                                 MOV                      AH,0
	                                 INT                      16H
	                                 ret


									 
	continue_player1:                
	                                 mov                      PlayerScore1,al
		
	                                 mov                      ax , 0
	                                 mov                      first_time_flag,0

	                                 movecursor               200,100
	                                 print_message            msg_goal

	;read char
	                                 MOV                      AH,0
	                                 INT                      16H
	                                 ret
	AFTER_CHECK_3:                   

	;       Check if the ball is colliding with the right paddle
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_RIGHT_X && BALL_X < PADDLE_RIGHT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_RIGHT_Y && BALL_Y < PADDLE_RIGHT_Y + PADDLE_HEIGHT
		
	                                 MOV                      AX,BALL_X
	                                 ADD                      AX,BALL_SIZE
	                                 CMP                      AX,PADDLE_RIGHT_X
	                                 JNG                      CHECK_COLLISION_WITH_LEFT_PADDLE	;if there's no collision check for the left paddle collisions
		
	                                 MOV                      AX,PADDLE_RIGHT_X
	                                 ADD                      AX,PADDLE_WIDTH
	                                 CMP                      BALL_X,AX
	                                 JNL                      CHECK_COLLISION_WITH_LEFT_PADDLE	;if there's no collision check for the left paddle collisions
		
	                                 MOV                      AX,BALL_Y
	                                 ADD                      AX,BALL_SIZE
	                                 CMP                      AX,PADDLE_RIGHT_Y
	                                 JNG                      CHECK_COLLISION_WITH_LEFT_PADDLE	;if there's no collision check for the left paddle collisions
		
	                                 MOV                      AX,PADDLE_RIGHT_Y
	                                 ADD                      AX,PADDLE_HEIGHT
	                                 CMP                      BALL_Y,AX
	                                 JNL                      CHECK_COLLISION_WITH_LEFT_PADDLE	;if there's no collision check for the left paddle collisions
		
	;       If it reaches this point, the ball is colliding with the right paddle

	                                 NEG                      BALL_VELOCITY_X                 	;reverses the horizontal velocity of the ball
	; NEG BALL_VELOCITY_Y              ;reverses the horizontal velocity of the ball
	                                 RET
	;       Check if the ball is colliding with the left paddle
	CHECK_COLLISION_WITH_LEFT_PADDLE:
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
		

	                                 MOV                      AX,BALL_X
	                                 ADD                      AX,BALL_SIZE
	                                 CMP                      AX,PADDLE_LEFT_X
	                                 JNG                      AFTER_CHECK                     	;if there's no collision check for the left paddle collisions
		
	                                 MOV                      AX,PADDLE_LEFT_X
	                                 ADD                      AX,PADDLE_WIDTH
	                                 CMP                      BALL_X,AX
	                                 JNL                      AFTER_CHECK                     	;if there's no collision check for the left paddle collisions
		
	                                 MOV                      AX,BALL_Y
	                                 ADD                      AX,BALL_SIZE
	                                 CMP                      AX,PADDLE_LEFT_Y
	                                 JNG                      AFTER_CHECK                     	;if there's no collision check for the left paddle collisions
		
	                                 MOV                      AX,PADDLE_LEFT_Y
	                                 ADD                      AX,PADDLE_HEIGHT
	                                 CMP                      BALL_Y,AX
	                                 JNL                      AFTER_CHECK                     	;if there's no collision check for the left paddle collisions
		
	;       If it reaches this point, the ball is colliding with the right paddle

	                                 NEG                      BALL_VELOCITY_X                 	;reverses the horizontal velocity of the ball
	; NEG BALL_VELOCITY_Y              ;reverses the horizontal velocity of the ball
	                                 RET
	;       Check if the ball is colliding with the left paddle
	AFTER_CHECK:                     
                  
	                                 RET

		
MOVE_BALL ENDP



DRAW_PADDLES PROC NEAR
		
	                                 MOV                      CX,PADDLE_LEFT_X                	;set the initial column (X)
	                                 MOV                      DX,PADDLE_LEFT_Y                	;set the initial line (Y)
		
	DRAW_PADDLE_LEFT_HORIZONTAL:     
	                                 MOV                      AH,0Ch                          	;set the configuration to writing a pixel
	                                 MOV                      AL,0Fh                          	;choose white as color
	                                 MOV                      BH,00h                          	;set the page number
	                                 INT                      10h                             	;execute the configuration
			
	                                 INC                      CX                              	;CX = CX + 1
	                                 MOV                      AX,CX                           	;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y -> We go to the next line,N -> We continue to the next column
	                                 SUB                      AX,PADDLE_LEFT_X
	                                 CMP                      AX,PADDLE_WIDTH
	                                 JNG                      DRAW_PADDLE_LEFT_HORIZONTAL
			
	                                 MOV                      CX,PADDLE_LEFT_X                	;the CX register goes back to the initial column
	                                 INC                      DX                              	;we advance one line
			
	                                 MOV                      AX,DX                           	;DX - PADDLE_LEFT_Y > PADDLE_HEIGHT (Y -> we exit this procedure,N -> we continue to the next line
	                                 SUB                      AX,PADDLE_LEFT_Y
	                                 CMP                      AX,PADDLE_HEIGHT
	                                 JNG                      DRAW_PADDLE_LEFT_HORIZONTAL
			
			
	                                 MOV                      CX,PADDLE_RIGHT_X               	;set the initial column (X)
	                                 MOV                      DX,PADDLE_RIGHT_Y               	;set the initial line (Y)
		
	DRAW_PADDLE_RIGHT_HORIZONTAL:    
	                                 MOV                      AH,0Ch                          	;set the configuration to writing a pixel
	                                 MOV                      AL,0Fh                          	;choose white as color
	                                 MOV                      BH,00h                          	;set the page number
	                                 INT                      10h                             	;execute the configuration
			
	                                 INC                      CX                              	;CX = CX + 1
	                                 MOV                      AX,CX                           	;CX - PADDLE_RIGHT_X > PADDLE_WIDTH (Y -> We go to the next line,N -> We continue to the next column
	                                 SUB                      AX,PADDLE_RIGHT_X
	                                 CMP                      AX,PADDLE_WIDTH
	                                 JNG                      DRAW_PADDLE_RIGHT_HORIZONTAL
			
	                                 MOV                      CX,PADDLE_RIGHT_X               	;the CX register goes back to the initial column
	                                 INC                      DX                              	;we advance one line
			
	                                 MOV                      AX,DX                           	;DX - PADDLE_RIGHT_Y > PADDLE_HEIGHT (Y -> we exit this procedure,N -> we continue to the next line
	                                 SUB                      AX,PADDLE_RIGHT_Y
	                                 CMP                      AX,PADDLE_HEIGHT
	                                 JNG                      DRAW_PADDLE_RIGHT_HORIZONTAL
			
	                                 RET
DRAW_PADDLES ENDP


MOVE_PADDLES PROC NEAR                                                                    		;process movement of the paddles
		
	;       Left paddle movement
		
	;check if any key is being pressed (if not check the other paddle)
	                                 MOV                      AH,01h
	                                 INT                      16h
	                                 JZ                       CHECK_RIGHT_PADDLE_MOVEMENT     	;ZF = 1, JZ -> Jump If Zero
		
	;check which key is being pressed (AL = ASCII character)
	                                 MOV                      AH,00h
	                                 INT                      16h
		
	;if it is 'w' or 'W' move up
	                                 CMP                      AL,77h                          	;'w'
	                                 JE                       MOVE_LEFT_PADDLE_UP
	                                 CMP                      AL,57h                          	;'W'
	                                 JE                       MOVE_LEFT_PADDLE_UP
		
	;if it is 's' or 'S' move down
	                                 CMP                      AL,73h                          	;'s'
	                                 JE                       MOVE_LEFT_PADDLE_DOWN
	                                 CMP                      AL,53h                          	;'S'
	                                 JE                       MOVE_LEFT_PADDLE_DOWN
	                                 JMP                      CHECK_RIGHT_PADDLE_MOVEMENT
		
	MOVE_LEFT_PADDLE_UP:             
	                                 MOV                      AX,PADDLE_VELOCITY
	                                 SUB                      PADDLE_LEFT_Y,AX
			
	                                 MOV                      AX,WINDOW_BOUNDS
	                                 CMP                      PADDLE_LEFT_Y,AX
	                                 JL                       FIX_PADDLE_LEFT_TOP_POSITION
	                                 JMP                      CHECK_RIGHT_PADDLE_MOVEMENT
			
	FIX_PADDLE_LEFT_TOP_POSITION:    
	                                 MOV                      PADDLE_LEFT_Y,AX
	                                 JMP                      CHECK_RIGHT_PADDLE_MOVEMENT
			
	MOVE_LEFT_PADDLE_DOWN:           
	                                 MOV                      AX,PADDLE_VELOCITY
	                                 ADD                      PADDLE_LEFT_Y,AX
	                                 MOV                      AX,WINDOW_HEIGHT
	                                 SUB                      AX,WINDOW_BOUNDS
	                                 SUB                      AX,PADDLE_HEIGHT
	                                 CMP                      PADDLE_LEFT_Y,AX
	                                 JG                       FIX_PADDLE_LEFT_BOTTOM_POSITION
	                                 JMP                      CHECK_RIGHT_PADDLE_MOVEMENT
			
	FIX_PADDLE_LEFT_BOTTOM_POSITION: 
	                                 MOV                      PADDLE_LEFT_Y,AX
	                                 JMP                      CHECK_RIGHT_PADDLE_MOVEMENT
		
		
	;       Right paddle movement
	CHECK_RIGHT_PADDLE_MOVEMENT:     
		
	;if it is 'o' or 'O' move up
	                                 CMP                      Ah,48H                          	;'o'
	                                 JE                       MOVE_RIGHT_PADDLE_UP

			
	;if it is 'l' or 'L' move down
	                                 CMP                      AH,50H                          	;'l'
	                                 JE                       MOVE_RIGHT_PADDLE_DOWN
	                                 JMP                      EXIT_PADDLE_MOVEMENT
			

	MOVE_RIGHT_PADDLE_UP:            
	                                 MOV                      AX,PADDLE_VELOCITY
	                                 SUB                      PADDLE_RIGHT_Y,AX
				
	                                 MOV                      AX,WINDOW_BOUNDS
	                                 CMP                      PADDLE_RIGHT_Y,AX
	                                 JL                       FIX_PADDLE_RIGHT_TOP_POSITION
	                                 JMP                      EXIT_PADDLE_MOVEMENT
				
	FIX_PADDLE_RIGHT_TOP_POSITION:   
	                                 MOV                      PADDLE_RIGHT_Y,AX
	                                 JMP                      EXIT_PADDLE_MOVEMENT
			
	MOVE_RIGHT_PADDLE_DOWN:          
	                                 MOV                      AX,PADDLE_VELOCITY
	                                 ADD                      PADDLE_RIGHT_Y,AX
	                                 MOV                      AX,WINDOW_HEIGHT
	                                 SUB                      AX,WINDOW_BOUNDS
	                                 SUB                      AX,PADDLE_HEIGHT
	                                 CMP                      PADDLE_RIGHT_Y,AX
	                                 JG                       FIX_PADDLE_RIGHT_BOTTOM_POSITION
	                                 JMP                      EXIT_PADDLE_MOVEMENT
				
	FIX_PADDLE_RIGHT_BOTTOM_POSITION:
	                                 MOV                      PADDLE_RIGHT_Y,AX
	                                 JMP                      EXIT_PADDLE_MOVEMENT
		
	EXIT_PADDLE_MOVEMENT:            
		
	                                 RET
		
MOVE_PADDLES ENDP

	;********************************************************************** CLEAR ***************************************
CLEAR_SCREEN PROC NEAR
	                                 MOV                      AH,00h                          	;set the configuration to video mode
	                                 MOV                      AL,13h                          	;choose the video mode
	                                 INT                      10h                             	;execute the configuration
		
	                                 MOV                      AH,0Bh                          	;set the configuration
	                                 MOV                      BH,00h                          	;to the background color
	                                 MOV                      BL,00h                          	;choose black as background color
	                                 INT                      10h                             	;execute the configuration
			
	                                 RET
CLEAR_SCREEN ENDP


portinitialization proc near
	; pusha
	;Set Divisor Latch Access Bit
	                                 mov                      dx, 3fbh                        	; Line Control Register
	                                 mov                      al, 10000000b                   	;Set Divisor Latch Access Bit
	                                 out                      dx, al                          	;Out it

	;Set LSB byte of the Baud Rate Divisor Latch register.
	                                 mov                      dx, 3f8h
	                                 mov                      al, 0ch
	                                 out                      dx, al

	;Set MSB byte of the Baud Rate Divisor Latch register.
	                                 mov                      dx, 3f9h
	                                 mov                      al, 00h
	                                 out                      dx, al

	;Set port configuration
	                                 mov                      dx,3fbh
	                                 mov                      al,00011011b
	;0:Access to Receiver buffer, Transmitter buffer
	;0:Set Break disabled
	;011:Even Parity
	;0:One Stop Bit
	;11:8bits
	                                 out                      dx,al
	                                 RET
portinitialization endp




SendStringName proc near
	; Check that Transmitter Holding Register is Empty
	                                 mov                      cx, 10
	                                 LEA                      SI,name1
	lp_s:                            
	                                 mov                      dx , 3FDH                       	; Line Status Register
	AGAIN:                           In                       al , dx                         	;Read Line Status
	                                 test                     al , 00100000b
	                                 JZ                       AGAIN                           	;Not empty

	;If empty put the VALUE in Transmit data register
	                                 mov                      dx , 3F8H                       	; Transmit data register
	                                 mov                      al,[si]
	                                 inc                      si
	                                 out                      dx , al
	                                 loop                     lp_s
	                                 RET
SendStringName endp
SendStringchat proc near
	; Check that Transmitter Holding Register is Empty
	                                 mov                      cx, 30
	                                 LEA                      SI,chat_player1
	lp_s_3:                          
	                                 mov                      dx , 3FDH                       	; Line Status Register
	AGAIN_2:                         In                       al , dx                         	;Read Line Status
	                                 test                     al , 00100000b
	                                 JZ                       AGAIN_2                         	;Not empty

	;If empty put the VALUE in Transmit data register
	                                 mov                      dx , 3F8H                       	; Transmit data register
	                                 mov                      al,[si]
	                                 inc                      si
	                                 out                      dx , al
	                                 loop                     lp_s_3
	                                 RET
SendStringchat endp

RecieveStringChat proc near

	                                 mov                      cx, 30
	                                 LEA                      SI,chat_player2
	lp_s_4:                          
	;Check that Data is Ready
	                                 mov                      dx , 3FDH                       	; Line Status Register
	CHK_2:                           in                       al , dx
	                                 test                     al , 1
	                                 JZ                       CHK_2                           	;Not Ready
	;If Ready read the VALUE in Receive data register
	                                 mov                      dx , 03F8H
	                                 in                       al , dx
	                                 mov                      [SI] , al
	                                 inc                      SI
	                                 loop                     lp_s_4
	                                 ret
		

RecieveStringChat ENDP
RecieveStringName proc near

	                                 mov                      cx, 10
	                                 LEA                      SI,name2
	lp_s_2:                          
	;Check that Data is Ready
	                                 mov                      dx , 3FDH                       	; Line Status Register
	CHK:                             in                       al , dx
	                                 test                     al , 1
	                                 JZ                       CHK                             	;Not Ready
	;If Ready read the VALUE in Receive data register
	                                 mov                      dx , 03F8H
	                                 in                       al , dx
	                                 mov                      [SI] , al
	                                 inc                      SI
	                                 loop                     lp_s_2
	                                 ret
		

RecieveStringName ENDP


	;======================================================================== MAIN =================================================================
main proc far
	                                 mov                      ax,@DATA
	                                 mov                      ds,ax
	;****************************************** serial intializaion

	;graphics mode
	                                 CONVERT_TO_GRAPHICS_MODE




	; ;draw hellow screen image
	                                 HELLO_SCREEN


	; ; read character

	                                 MOV                      AH,0
	                                 INT                      16H
	                                 CMP                      AL,'1'
	                                 je                       next_screen

	next_screen:                     

	                                 CONVERT_TO_TEXT_MODE
	; SET_BACKGROUND_COLOR RED

	                                 clear
	                                ;  CALL                     portinitialization
	                                 movecursor               20,5
	                                 print_message            msg1
	                                 movecursor               20,6
	                                 read_string              name1
	;
	                                ;  call                     SendStringName
	                                ;  call                     RecieveStringName
	                                ;  clear
	                                 movecursor               20,8
	                                 print_message            msg_sec
	                                 read_string              name2
	                                 movecursor               20,10
	                                 print_message            name2+2
	                                 mov                      ah,0
	                                 int                      16h
	choise_screen:                   
	                                 CONVERT_TO_TEXT_MODE
	                                 clear
	                                 movecursor               0,0
	                                 print_message            Screen3_str
	;read char
	                                 mov                      ah,0
	                                 int                      16h
	;check char
	                                 cmp                      al,31h                          	;wait for 1
	                                 jne                      lc2
	                                 call                     startgame
	                                 jmp                      after_compareF
	lc2:                             cmp                      al,33h                          	;wait for 3
	                                 jne                      Lc3
	                                 call                     exit
	                                 jmp                      after_compareF
	Lc3:                             cmp                      al,32h                          	;wait for 2
	                                 jne                      after_compareF
	                                 call                     chat
	after_compareF:                  
	
	                                 JMP                      choise_screen










	                                 hlt
main ENDP
END main