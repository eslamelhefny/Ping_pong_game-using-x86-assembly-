;********************************************hello screen  macro***********************************************
HELLO_SCREEN MACRO
    ; Open file
        MOV AH, 3Dh
        MOV AL, 0 ; read only
        LEA DX, HelloScreenFilename
        INT 21h   
        MOV [HelloScreenFilehandle], AX
        ;ReadData
        MOV AH,3Fh
        MOV BX, [HelloScreenFilehandle]
        MOV CX,HelloScreenWidth*HelloScreenHeight ; number of bytes to read
        LEA DX, HelloScreenData
        INT 21h	
        LEA BX , HelloScreenData ; BL contains index at the current drawn pixel
        MOV CX,170
        MOV DX,0
        MOV AH,0ch
        
        ; Drawing loop
        drawLoop:
            MOV AL,[BX]
            INT 10h 
            INC CX
            INC BX
            CMP CX,HelloScreenWidth
        JNE drawLoop 
            MOV CX , 0
            INC DX
            CMP DX , HelloScreenHeight
        JNE drawLoop
            ;CloseFile
            MOV AH, 3Eh
            MOV BX, [HelloScreenFilehandle]
            INT 21h

    
ENDM HELLO_SCREEN
;********************************************print message macro***********************************************
print_message macro message
	              mov ah,9
	              mov dx,offset message
	              int 21h
    endm
;******************************************** move cursor macro***********************************************
movecursor macro x,y
	           mov ah,2
	           mov bh,0
	           mov dl,x
	           mov dh,y
	           int 10h
    endm
;******************************************** clear  macro ***********************************************
clear macro
	      mov ax,0600h
	      mov bh,07
	      mov cx,0
	      mov dx,184fh
	      int 10h
    endm
;******************************************** read string macro ***********************************************
read_string macro  string
	            mov ah,0AH
	            mov dx,offset string
	            int 21h
    endm
;******************************************** set background color macro ***********************************************
SET_BACKGROUND_COLOR macro  color 
mov ah,0Bh
mov bh,00h
mov bl,color
int 10h
endm SET_BACKGROUND_COLOR

;******************************************** Draw pixel macro ***********************************************

DRAW_PIXEL macro x_axis, y_axis, color
MOV AH,0CH
MOV AL,color
MOV BH,00h
MOV CX,x_axis
MOV DX,y_axis
INT 10H

endm DRAW_PIXEL

CONVERT_TO_TEXT_MODE macro 

        MOV AH, 0
        MOV AL, 3h
        INT 10h

endm CONVERT_TO_TEXT_MODE

CONVERT_TO_GRAPHICS_MODE macro
	            MOV           AH, 0
	            MOV           AL, 13h
	            INT           10h
endm CONVERT_TO_GRAPHICS_MODE







DrawbarleftP MACRO column,row,color
         LOCAL L1,L2
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,10   

L1:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+10
         JNZ L1
         JZ  L2      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L2:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L1
         pop row       ;here we return back the original value of row  
ENDM DrawbarleftP 
DrawbarrightP MACRO column,row,color
         LOCAL L3,L4
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,10   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L3:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+10
         JNZ L3
         JZ  L4      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L4:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L3
         pop row       ;here we return back the original value of row  
ENDM DrawbarrightP 
Drawbarleft MACRO column,row,color
         LOCAL L5,L6
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,100   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L5:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+5
         JNZ L5
         JZ  L6      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L6:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L5
         pop row       ;here we return back the original value of row  
ENDM Drawbarleft 
Drawbarleftup MACRO column,row,color
         LOCAL L5,L6
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,20   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L5:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+5
         JNZ L5
         JZ  L6      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L6:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L5
         pop row       ;here we return back the original value of row  
ENDM Drawbarleftup 
Drawbarleftdown MACRO column,row,color
         LOCAL L5,L6
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,20   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L5:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+5
         JNZ L5
         JZ  L6      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L6:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L5
         pop row       ;here we return back the original value of row  
ENDM Drawbarleftdown 
Drawbarrightup MACRO column,row,color
         LOCAL L7,L8
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,20  ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L7:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+5
         JNZ L7
         JZ  L8      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L8:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L7
         pop row       ;here we return back the original value of row  
ENDM Drawbarrightup
Drawbarrightdown MACRO column,row,color
         LOCAL L7,L8
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,20  ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L7:  INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+5
         JNZ L7
         JZ  L8      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L8:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L7
         pop row       ;here we return back the original value of row  
ENDM Drawbarrightdwon
Drawbarup MACRO column,row,color
         LOCAL L9,L10
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,5   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L9:      INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+155
         JNZ L9
         JZ  L10      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L10:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L9
         pop row       ;here we return back the original value of row  
ENDM Drawbarup 
Drawbardown MACRO column,row,color
 LOCAL L11,L12
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,5   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L11:      INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+155
         JNZ L11
         JZ  L12      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L12:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L11
         pop row       ;here we return back the original value of row  
ENDM Drawbardown
Drawmidlleline MACRO column,row,color
 LOCAL L11,L12
         MOV CX,column ;moving the start column in CX
         MOV DX,row    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push row      ;keeping the original value of the row in stack to return back to the main proc with it 
         add row,100   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L11:      INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,column+2
         JNZ L11
         JZ  L12      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L12:    MOV CX,column ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,row    ;comparing with the updated value of row"row + 60"
         JNZ L11
         pop row       ;here we return back the original value of row  
ENDM Drawmiddleline



 draw_rectangle macro s_col,s_raw,e_col,e_raw,color
 LOCAL L11,L12
 DRAW_PIXEL macro x_axis, y_axis, color
MOV AH,0CH
MOV AL,color
MOV BH,00h
MOV CX,x_axis
MOV DX,y_axis
INT 10H

endm DRAW_PIXEL
 
 
 
         MOV CX,s_col ;moving the start column in CX
         MOV DX,s_raw    ;moving the start row in DX
         MOV AL,color  ;moving color of the bar in AL
         MOV AH,0CH
         push s_raw      ;keeping the original value of the row in stack to return back to the main proc with it 
         add s_raw,5   ;here it means to draw from the value of row to the value of row +60 ; it means to draw 60 row in specific place in the screen

L11:      INT 10H
         INC CX        ; we increment CX to draw pixel in the first row in all columns from cloumn to column+10 so here the number of column drawn is 10
         CMP CX,e_col
         JNZ L11
         JZ  L12      ;if the current row is filled with pixels in all its columns so go to increme nt the row and start again in the new row

L12:    MOV CX,s_col ;moving the initial value of columns
         INC DX        ;go to the next row
         CMP DX,e_raw    ;comparing with the updated value of row"row + 60"
         JNZ L11
         pop s_raw       ;here we return back the original value of row  
endm draw_rectangle 

;******************************************** Draw pixel macro ***********************************************

; DELAY macro 
;     ;get system time 
;     start_loop: mov ah,2ch
;                 int 21h
;                 ;after this line we can find in CH : hours , CL : minutes , DH : seconds , DL : 1/100 of seconds 

;                 ;compare with prevous time 
;                 cmp DL,PREV_TIME
;                 je start_loop
;                 ;update new time 
;                 mov PREV_TIME,dl

                


; DELAY endm

