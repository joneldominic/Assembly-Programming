  .model small
  .stack
  .data
  
   oddFibSeriesSet db 7 Dup(?)
   maxSetSize dw 7
   AXTempHolder dw 0000h
   DXTempHolder dw 0001h 
   tempNumHolder db ?
  
  .code
main proc near
   Mov AX, @Data
   Mov DS, AX
   Mov ES, AX
   
   ;calling myFibonnacci Function
   call myFibonnacci
   
  ;termination code of the program
   mov AX, 4C00H
   int 21H 
main endp


;Fibonnacci Series
myFibonnacci proc near
                    
   Lea SI, oddFibSeriesSet
   
   myLoop:

       Mov AX, AXTempHolder
       Mov DX, DXTempHolder
       
       Add DH, DL
       Mov AL, DH
       Mov DH, DL
       Mov DL, AL
       Mov tempNumHolder, AL
       
       Mov AXTempHolder, AX
       Mov DXTempHolder, DX
       
       ;Checking if number is Greater than 1
       Cmp AL, 1
       JBE skipStoring
       
           ;Checking for Odd or Even
           Mov DX, 0               
           Mov BX, 2
           Div BX 
           Cmp DX, 0
           JZ skipStoring
       
               Mov AL, tempNumHolder
               Mov [SI], AX
               Inc SI 
               
                   cmp maxSetSize, 0
                   JE skipStoring
                   
                        dec maxSetSize
       
       
       skipStoring:
       Mov CX, maxSetSize       
       cmp  maxSetSize, 0
       JNE myLoop
   
   

ret
myFibonnacci endp