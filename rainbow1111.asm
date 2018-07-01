.model small
.stack
.data
       
    colors db 0CCH, 0CEH, 0EEH, 0AAH, 099H, 051H, 55H
    numOfColors db 7  
    row db 00
    col db 00 
    width db 3   
    
.code
main proc near
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX
      
    call setVideoMode
    call drawColors
   
    Mov AX, 4C00H
    Int 21H
main endp   

setVideoMode proc near 
    
    Mov AH, 00H  
    mov AL, 03H  
    Int 10H     
    
ret
setVideoMode endp    

drawColors proc near  
     
    Lea SI, colors  
    
      
    drawColorLine:
        drawColor:
            call setCursor
            Mov AH, 09H
            Mov AL, 0B1H ;ascii
            Mov BH, 00   ;page number
            Mov BL, [SI]  ;BG, FG
            Mov CX, 80   ;number of chars
            Int 10H
            inc row
            Dec width
            JNZ drawColor
            Mov width, 3
        inc SI
        Dec numOfColors
        JNZ drawColorLine
ret
drawColors endp     

setCursor proc near 
    
    ;Set Cursor Position
    Mov AH, 02H 
    Mov BH, 00    ;page number = 0
    Mov DH, row    ;row 
    Mov DL, col    ;Column 
    Int 10H
ret
setCursor endp