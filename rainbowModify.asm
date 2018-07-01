.model small
.stack
.data
       
    colors db 0CCH, 0CEH, 0EEH, 0AAH, 099H, 051H, 55H
    numOfColors db 7  
    row db 05       ;default
    col db 03       ;default
    length dw 30    ;default
    width db 2 
    
    
.code
main proc near
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX
    
    
    call setVideoMode
    call drawRainbow
    
    
   
    Mov AX, 4C00H
    Int 21H
main endp   

setVideoMode proc near 
    
    Mov AH, 00H  
    mov AL, 03H  
    Int 10H     
    
ret
setVideoMode endp 


drawRainbow proc near
       
    
    Mov numOfColors, 07 
    Mov row, 11
    Mov col, 1
    Mov length, 5 
    Call drawColors   
   

    Mov numOfColors, 07 
    Mov row, 10
    Mov col, 4
    Mov length, 5 
    Call drawColors
    
    Mov numOfColors, 07 
    Mov row, 9
    Mov col, 7
    Mov length, 7 
    Call drawColors  
    
    Mov numOfColors, 07 
    Mov row, 8
    Mov col, 10
    Mov length, 9 
    Call drawColors  
    
    Mov numOfColors, 07 
    Mov row, 7
    Mov col, 13
    Mov length, 11 
    Call drawColors 
    
    Mov numOfColors, 07 
    Mov row, 6
    Mov col, 16
    Mov length, 13 
    Call drawColors
     
    
    Mov numOfColors, 07 
    Mov row, 11
    Mov col, 50
    Mov length, 5 
    Call drawColors
    
    
       
    Mov numOfColors, 07 
    Mov row, 10
    Mov col, 46
    Mov length, 5 
    Call drawColors
    
     Mov numOfColors, 07 
    Mov row, 9
    Mov col, 41
    Mov length, 7 
    Call drawColors 
    
    
    Mov numOfColors, 07 
    Mov row, 8
    Mov col, 36
    Mov length, 9 
    Call drawColors  
                
    
     
    Mov numOfColors, 07 
    Mov row, 7
    Mov col, 31
    Mov length, 11 
    Call drawColors   
    
    
    Mov numOfColors, 07 
    Mov row, 6
    Mov col, 26
    Mov length, 13 
    Call drawColors 
    

    Mov numOfColors, 07 
    Mov row, 5
    Mov col, 18
    Mov length, 16 
    Call drawColors 
    
    
    Mov numOfColors, 07 
    Mov row, 4
    Mov col, 21
    Mov length, 10 
    Call drawColors 
       

ret
drawRainbow endp

drawColors proc near  
     
    Lea SI, colors  
    
      
    drawColorLine:
        drawColor:
            call setCursor
            Mov AH, 09H
            Mov AL, 0B1H ;ascii
            Mov BH, 00   ;page number
            Mov BL, [SI]  ;BG, FG
            Mov CX, length   ;number of chars
            Int 10H
            inc row
            Dec width
            JNZ drawColor
            Mov width, 2
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

