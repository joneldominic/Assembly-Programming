.model small       
                    
 .stack            
 .data              
  
    num DW 05H         ;5!
         
 .code              
main proc near       
 mov Ax, @data
 mov Ds, Ax
 mov Es, Ax 
 
 
 mov CX, num
 mov AX, 1   
 
 
 START:  
 
    MOV DX, CX 
    MUL DX 
     
 LOOP START;decrement CX, return to start

 MOV DX, AX ;DX register now holds the final result
    
 ;termination code of the program
 mov AX, 4C00H
 int 21H
 
main endp