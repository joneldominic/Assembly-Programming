.model small
.stack 64
.data
    Num dw 0
     
    
.code     

Main proc near
    MOV AX, @data
    MOV DS, AX
    MOV ES, AX
    MOV CX, 05H    ;5 sequence only
    MOV AX, 0000H
    
    myLoop:     
           
        MOV DX, Num
        ADD DX, AX
        MOV AX, DX   
        INC Num
        
          
    LOOP myLoop        