.model small       
                    
.stack             
.data              
 
   myBool db 0              ; 1 if number is prime, 0 if not
   number dw 7               ; number to be determine if prime or not
   
                 

 
.code              

main proc near       
 mov Ax, @data
 mov Ds, Ax
 mov Es, Ax
 mov Cx, 2 
              
    mov AX, number  
    div CX                  ; DX:AX/CX, DX=Remainder, AX=Quotient
    mov CX, DX              ; Assign the remainder value into CX
    JCXZ numberIsNotPrime   ; jump into numberIsNotPrime label when number is not Prime (CX != 0)
    
        mov myBool, 1
        JNE assignMyBool    ; jump into assignMyBool label
     
   numberIsNotPrime:
        mov myBool, 0
 
   assignMyBool: 
        MOV AL, myBool       ; Assign 1 to AL if number is prime, 0 if not                 
                      
                      
 ;termination code of the program
 mov AX, 4C00H
 int 21H
 
main endp