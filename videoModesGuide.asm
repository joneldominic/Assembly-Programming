.model small
.stack
.data
     
     address db "HELLO" 
     

.code
main proc near
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX 
    
    
    ;Set Video Mode
    ;Mov AH, 00H  ;request (Function)
    ;mov AL, 03H  ;standard color text
    ;Int 10H    
    
    ;Set Cursor Size
    ;Mov AH, 01H    ;request
    ;Mov CH, 00    ;top of cursor (start scan line)
    ;Mov CL, 14    ;bottom or end scan line
    ;Int 10H
    
    ;Set Cursor Position
    ;Mov AH, 02H 
    ;Mov BH, 00    ;page number = 0
    ;Mov DH, 12    ;row = 12
    ;Mov DL, 30    ;Column = 30
    ;Int 10H
             
          
    ;Return Cursor Status
    ;Mov AH, 03H
    ;Mov BH, 00H   ;page number
    ;Int 10H
    ;CH = start scan line   CL = ending SL
    ;DH = Row               DL = Column
    
    
    ;Select Active Page
    ;Mov AH, 05H
    ;Mov AL, 2
    ;Int 10H 
    
    ;Select Scroll Up Screen
    ;Mov AX, 0607H      ;AL = number of lines to scroll up
    ;Mov BH, 11H        ; leftmost 4 bit = Bkg, rightmost 4 bit fgd 
    ;Mov CX, 0C19H      ;starting row:column
    ;Mov DX, 1236H      ;ending row:column
    ;Int 10H    
    
    ;Scroll down Screen
    ;07H
    ;Works the same ith Scroll up
    
    ;Read Character and Attribute at Cursor
    ;Mov AH, 08H
    ;Mov BH, 00
    ;Int 10H
    ; AL = character
    ; AH = attribute of the char 
    
    ;Display Character and Attribute at Cursor (Its attribute can be set)
    ;AL = ASCII Characters
    ;BL = Attribute/pixel value
    ;BH = Page Number
    ;CX = Count
    ;Mov AH, 09H
    ;Mov AL, 01H     
    ;Mov BH, 00
    ;Mov BL, 16H     ;BG and FG
    ;Mov CX, 60      ;No. of repeated chars
    ;INT 10H
    
    ;Display Character at Cursor(Inherits current attrib)
    ;Mov AH, 0AH
    ;Mov AL, 00H      ;Char to Display
    ;Mov BH, 00       ;Page number
    ;Mov BL, 16H       ;Pixel Value
    ;Mov CX, 10       ;# of repetition
    ;Int 10H    
    
     
    ;Setting to Graphical mode
    ;mov ah, 0
    ;mov al, 13h
    ;int 10h  
     
     
    ;Write Pixel Dot
    ;AL = Color of pixel
    ;BH = Page number
    ;CX = Column
    ;DX = Row
    ;Mov AH, 0CH
    ;Mov AL, 02H
    ;Mov BH, 0
    ;Mov CX, 200 
    ;Mov DX, 50 
    ;Int 10H
    
    
    
    ;Read pixel Dot
    ;Mov AH, 0DH
    ;Mov BH, 0
    ;Mov CX, 80
    ;Mov DX, 110
    ;Int 10H
    ;Operation returns the pixel value at AL
         
     
    
    ;Display Character String
    ;Mov AH, 13H
    ;Mov AL, 01      ;Subfunction 00,01,02,03
    ;Mov BH, 00      ;Page number
    ;Mov BL, 02H      ;BG, FG
    ;Lea BP, address ;Address in ES:BP
    ;Mov CX, 05H  ;Length of String
    ;Mov DH, 05H     ;Screen row
    ;Mov DL, 05H     ;Screen row
    ;Int 10H
    ;Subfunctions
    ;00 = Disp string and attribute, no cursor advance
    ;01 = Disp string and Attrib, advane cursor
    ;02 = Disp Char then Attrib, no cursor advance
    ;03 = Disp Char then Attrib, advance cursor
    
    
    
    Mov AX, 4C00H
    Int 21H
main endp