.model small
.stack
.data
       
    colorBGWithBlackFG db 40H, 0C0H, 0E0H, 020H, 090H, 010H, 0D0H
    numOfColors db 7  
    colorNames db "RED","LIGHT RED","YELLOW","GREEN","LIGHT BLUE","BLUE","LIGHT MAGENTA"
    colorNameLength db 3H, 9H, 6H, 5H, 0AH, 4H, 0DH 
    lengthAcc dw ?
    
.code
main proc near
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX
    
    call setVideoMode
    call drawColors
    call writeColorName
    
    
    
    
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
    
    
    Lea SI, colorBGWithBlackFG
    Mov AX, 0700H           
    Mov CX, 0105H      
    Mov DX, 0349H
    
    drawColorLine:
        Mov BH, [SI]       
        Int 10H
        Inc SI
        Add CH, 3
        Add DH, 3
        Dec numOfColors
        JNZ drawColorLine
    
ret
drawColors endp

writeColorName proc near 
    

    ;Set Cursor Position
    Mov AH, 02H 
    Mov BH, 00    ;page number = 0
    Mov DH, 01    ;row 
    Mov DL, 05    ;Column 
    Int 10H
    
    Mov numOfColors, 7
    Lea SI, colorNameLength
    Lea DI, colorBGWithBlackFG
    
    Mov AH, 13H
    Mov AL, 01
    Mov CX, 0  
    Mov DH, 02H       ;Screen row
    Mov DL, 0AH       ;column      
    Mov BH, 00        ;Page number  
    Lea BP, colorNames  
    
    
    
    Mov BL, [DI]       ;BG, FG
    Mov CL, [SI]       ;Length of String
    Int 10H
    Lea BP, colorNames+3    
     Inc DI
    Inc SI
    Add DH, 03H
    Dec numOfColors  
          
                            
    Mov BL, [DI]       
    Mov CL, [SI]       
    Int 10H  
    Lea BP, colorNames+3+9 
    
    Inc DI
    Inc SI
    Add DH, 03H
    Dec numOfColors
        
        
    Mov BL, [DI]       
    Mov CL, [SI]      
    Int 10H  
    Lea BP, colorNames+3+9+6 
    
    Inc DI
    Inc SI
    Add DH, 03H
    Dec numOfColors   
        
    Mov BL, [DI]       
    Mov CL, [SI]       
    Int 10H  
    Lea BP, colorNames+3+9+6+5
    
    Inc DI
    Inc SI
    Add DH, 03H
    Dec numOfColors    
    
    Mov BL, [DI]       
    Mov CL, [SI]       
    Int 10H  
    Lea BP, colorNames+3+9+6+5+10
    
    Inc DI
    Inc SI
    Add DH, 03H
    Dec numOfColors   


    Mov BL, [DI]       
    Mov CL, [SI]      
    Int 10H  
    Lea BP, colorNames+3+9+6+5+10+4
    
    Inc DI
    Inc SI
    Add DH, 03H
    Dec numOfColors  
    
    Mov BL, [DI]       
    Mov CL, [SI]      
    Int 10H                                
        
ret
writeColorName endp