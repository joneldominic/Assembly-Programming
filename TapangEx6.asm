.model small       
                    
.stack             
.data              
  
  dataSet db 3,5,1,4,32,12,16,39,64,20
  dataSetSize dw 10              ; holds the number of elements in the dataSet
  whileLoopControl dw 0                
                 
.code              

main proc near       
    mov Ax, @data
    mov Ds, Ax
    mov Es, Ax
    
    
    call bubbleSort 
    call display                ; display elements after sorting operation
    
                      
    ;termination code of the program
    mov AX, 4C00H
    int 21H 
main endp


; Sort elements in dataSet in Ascending Order
bubbleSort proc near
    
    myWhileLoop: 
    
        dec dataSetSize
        
        mov CX, dataSetSize 
        lea SI, dataSet
        myInnerLoop:
            
            
            mov BH, [SI]
            mov BL, [SI+1]
            
            cmp BH, BL                  ; (BH < BL)
            JLE next                    ; jump to the next label if (BH < BL)
            
            mov whileLoopControl, 2     ; serves as control for the outer loop
            xchg BH, BL                 
            mov [SI], BH
            mov [SI+1], BL    
            
            next:
                inc SI
                jcxz exitLoop 
            
        
        loop myInnerLoop
        
        mov CX, whileLoopControl
    
   cmp CX, 0                            ; checks if no more swap occurs
   JE exitLoop                          ; exits the loop if there is no more swapping occurs
       
   loop myWhileLoop     
    
   exitLoop: 
       ret 
   
bubbleSort endp  


; Display each element in DL register
display proc near
    
   mov CX, 10                ; Number of elements to display
   lea SI, dataSet   
   
   disp:
        mov DL,[SI]
        inc SI  
   loop disp
    
ret
display endp