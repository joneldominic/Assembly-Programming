.model small        ;memory model
                    
 .stack             ;temp storage
 .data              ;data segment, where to declare variable
 
 ;place variable declarations here 
 ;sample dw 2,"$" ;sample variable, dw (define a 16bit memory location)
                 ;initialized by 2. 
                 ;$ sign is for termination of each variable.
                 
 y dw 0, "$"
 m dw 3, "$"
 x dw 5, "$"
 
 .code              ;code segment
main proc near       
 mov Ax, @data
 mov Ds, Ax
 mov Es, Ax 
 
 ;place source code here 
 ;mov DX, sample;DX=sample
 ;add DX,2;DX=DX+2
 ;mov AX,2;AX=2
 ;mul DX ;AX=AX*DX
 ;mov sample,AX;sample=AX
 
 mov DX, m
 mov AX, x
 mul DX
 add AX, 10
 mov y, AX 
 
 ;termination code of the program
 mov AX, 4C00H
 int 21H
 
main endp