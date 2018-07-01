.model small
.stack
.data   

    colors db 40H, 0E0H, 20H, 10H, 50H  
    numOfColors db 05H
    width db 03h  


.code
main proc near
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX  
              
    ;Set Video Mode
    MOV AH, 00H
    MOV AL, 03H
    INT 10H     
    
    
    LEA SI, colors    
    Mov AH, 07H
    Mov AL, width
    Mov CX, 0505H      
    Mov DX, 1349H
    
    drawColorLine:       
        Mov BH, [SI]              
        Int 10H
        INC SI
        ADD CH, width
        DEC numOfColors
        JNZ drawColorLine     
    
                          
    Mov AX, 4C00H
    Int 21H
main endp