 .model small
 .stack
 .data
    
    ;data declaration for (Bubble Sort) function
    dataSet db 5h, 2h, 4h, 3h, 1h, 14h, 23h, 11h, 6h, 10h, 7h, 13h, 16h, 10h, 1h
    dataSetSize dw 15           ;Size of the dataSet
    whileLoopControl dw ?
    ;--------------------------- 
    
    ;data for exploration
    datas dw 12h, 3, 01ABh, 100h
    ;---------------------------
    
    ;data for Exer2
    y dw ?                      ; y-int
    m dw 5h                     ; slope
    x dw 3h                     ; x-int
    b dw 0Ah            
    ;---------------------------
    
    ;data for Exer3
    numFac dw 5                 ;Number to be factor out
    ;---------------------------
    
    ;data for Exer4
    numToTest dw 5h
    divCtr dw 0
    divisorHolder dw ?
    myBoolPrime  dw 0           ;1 = prime 0 = not prime
    ;---------------------------
    
 .code

main proc near
    
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX 
    ;--------------------------
    
    ;----calling function -----
    ;call practice
    ;call Exer2
    ;call Exer3
    ;call Exer4   
  
    ;--------------------------
        
                   
    ;------ Cmp and Jmps ------               
    ;mov DH, 5
    ;mov DL, 5
    ;cmp DH, DL
    ;jne callShit
    ;mov DX, 00h
    ;callShit:
    ;    call practice
    ;--------------------------
                        
                        
    
                        
    ;---- Termination code----
    Mov AX, 4C00H
    int 21H

main endp

; Practice problem (Bubble Sort)
practice proc near
    
    myWhileLoop:
    
        Mov whileLoopControl, 0
        Dec dataSetSize
        
        Mov CX, dataSetSize
        Lea SI, dataSet
        myForLoop:
            
            Mov BH, [SI]
            Mov BL, [SI+1]
            Cmp BH, BL
            Jbe skipSwapping
            
            Mov whileLoopControl, 2
            xchg BH, BL
            Mov [SI], BH
            Mov [SI+1], BL
                        
            skipSwapping: 
                Inc SI
                                
        loop myForLoop
    
    Mov CX, whileLoopControl
    Jcxz skipLoop      
    loop myWhileLoop
    
    skipLoop:
          
ret
practice endp    


;Slope of a Line
Exer2 proc near
    
    Mov AX, m
    Mov BX, x
    Mul BX 
    Add AX, b
    Mov y, AX
       
ret
Exer2 endp


;Factorial
Exer3 proc near 
    
    Mov AX, numFac
    
    
    myLoop:
        
        Dec numFac
        Mov CX, numFac
        Mul CX
        
    loop myLoop
    
    Mov DX, AX             ; Factorial of numFac

ret
Exer3 endp 
          

;Prime numbers
Exer4 proc near
    
    ; Get the number half of the number to serve as starting divisors     
    Mov AX, numToTest
    Mov CX, 2
    Div CX
    Mov divisorHolder, AX
    
    
    myPrimeTester:
    
        Mov AX, numToTest
        Mov CX, divisorHolder
        Div CX
        
        Cmp DX, 0
        Jnz SkipCtr
        Inc divCtr
        
        SkipCtr:
        dec divisorHolder
        
    Loop myPrimeTester
    
    Mov BX, divCtr
    Cmp BX, 1
    Jne notPrime
    Mov myBoolPrime, 1
    
    notPrime:
    Mov DX, myBoolPrime
            
ret
Exer4 endp