.model small
.stack
.data
    
    gameName db "ROCK-PAPER-SCISSORS"
    gameDisc1 db "This game is a zero sum hand game usually played between two people in which each player simultaneously forms one of three shapes with an outstretched hand."
    gameDisc2 db " The game has only three possible outcomes other than a tie: a player who decides to play rock will beat another player who has chosen scissors (rock crushes scissors) but will lose to one who has played paper (paper covers rock) a play of paper will lose to a play of scissors (scissors cut paper)." 
    gameDisc3 db " If both players throw the same shape, the game is tied and is usually immediately replayed to break the tie."
    gameStart db "Let the game begin: (R = Rock | P = Paper | S = Scissors)"
    intputNote db "Note: Program will keep on asking player for valid input"
    player1 db "Player 1: "
    player2 db "Player 2: "  
    player1Input db ? ;(R/P/S)  
    player2Input db ? ;(R/P/S)
    inputStatus db 'X';(O = valid, X = not valid, default into X(not valid))
    gameResult db ?   ;(1 = player 1 wins, 2 = player 2 wins, 'D' = Draw)  
    winner1 db "Congratulations Player 1 You Win"
    winner2 db "Congratulations Player 2 You Win"
    draw db "It's a Draw" 
    declareResultHeader db "Game Over: "

.code
main proc near
    Mov AX, @Data
    Mov DS, AX
    Mov ES, AX
    
    call setVideoMode03 
    call gameHeader
    call RPSInterf
    call evaluator
    call declareWinner
   
    
    
    
    Mov AX, 4C00H
    Int 21H
main endp 

setVideoMode03 proc near
   
    Mov AH, 00
    Mov AL, 03
    Int 10H 

ret
setVideoMode03 endp  

gameHeader  proc near
    
    ;Display game name
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, gameName
    Mov CX, 19 
    Mov DH, 0
    Mov DL, 0 
    Int 10H 
    
    ;Display game discription
    Lea BP, gameDisc1
    Mov CX, 564
    Mov DH, 1
    Mov DL, 0 
    Int 10H 
    
    ;Game begin 
    Lea BP, gameStart
    Mov CX, 57
    Mov DH, 10
    Mov DL, 0 
    Int 10H
    
    ;Note
    Lea BP, intputNote
    Mov CX, 56
    Mov DH, 11
    Mov DL, 0 
    Int 10H 
        
ret
gameHeader endp    

RPSInterf proc near   
    
    ;Player1
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, player1
    Mov CX, 10 
    Mov DH, 13
    Mov DL, 5 
    Int 10H
    
    ;Asks input for P1
    AskP1input:
        MOV AH, 08H 
        INT 21H
        call inputCheckAndNorm 
        
        ;Checks inputStatus
        Mov DH, inputStatus
        cmp DH, 'X'
        JE AskP1input   
        ;ask p1 again for input if current input is invalid
        
        Mov player1Input, AL    ;gets the input
        
        ;disp "*" on player input
        MOV AH, 0AH 
        MOV AL, '*' 
        MOV BH, 0 
        MOV BL, 1
        MOV CX, 1 
        INT 10H  
   
    
    ;Player2
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, player2
    Mov CX, 10 
    Mov DH, 15
    Mov DL, 5 
    Int 10H
    
    ;Asks input for P2
    AskP2input:
        MOV AH, 08H 
        INT 21H 
        call inputCheckAndNorm 
        
        ;Checks inputStatus
        Mov DH, inputStatus
        cmp DH, 'X'
        JE AskP2input   
        ;ask p2 again for input if current input is invalid
        
        Mov player2Input, AL    ;gets the input 
        
        ;disp "*" on player input
        Mov AH, 0AH 
        Mov AL, '*' 
        Mov BH, 0 
        Mov BL, 1
        Mov CX, 1 
        Int 10H 

       
 
ret
RPSInterf endp

inputCheckAndNorm proc near 
    ;initialize inputStatus = X
    Mov inputStatus, 'X'
    
    ;Checks input is within RPS
    cmp AL, 'R'
    JNE notBR 
        Mov inputStatus, 'O' ;(O = valid, X = not valid)              
    
    notBR:
    cmp AL, 'r'
    JNE notSR 
        Mov AL, 'R'
        Mov inputStatus, 'O' 
                      
    notSR:
    cmp AL, 'S' 
    JNE notBS 
        Mov inputStatus, 'O'               
    
    notBS:
    cmp AL, 's' 
    JNE notSS  
        Mov AL, 'S'
        Mov inputStatus, 'O'
    
    notSS:
    cmp AL, 'P' 
    JNE notBP 
        Mov inputStatus, 'O' 
        
    notBP:
    cmp AL, 'p' 
    JNE notSP  
        Mov AL, 'P'
        Mov inputStatus, 'O'
    
    notSP:
    
    ;If input is not within 'R', 'P', 'S' or 'r', 'p', 's'
    ;inputStatus remain 'X'     

ret
inputCheckAndNorm endp


evaluator proc near 
    
       
    ;Compare if both inputs are equal
    Mov DH, player1Input 
    Mov DL, player2Input
    cmp DH, DL
    JNE NotEqual
        Mov gameResult, 'D'     
        ret
        
    NotEqual:
    cmp DH, 'R'
    JE P1isRock
        cmp DH, 'P'
        JE P1isPaper
            cmp DH, 'S'
            JE P1isScissor
    
    
    P1isRock:
        cmp DL, 'S'
        JNE p2NotS
            ;R>S
            Mov gameResult, '1'     
            ret 
            
        p2NotS:
            ;R<P
            Mov gameResult, '2'     
            ret
            
    
    P1isPaper:
    
        cmp DL, 'R'
        JNE p2NotR
            ;P>R
            Mov gameResult, '1'     
            ret 
            
        p2NotR:
            ;P<S
            Mov gameResult, '2'     
            ret 
    
    P1isScissor: 
    
        cmp DL, 'P'
        JNE p2NotP
            ;S>P
            Mov gameResult, '1'     
            ret 
            
        p2NotP:
            ;S<R
            Mov gameResult, '2'     
            ret 
      
     ;(1 = player 1 wins, 2 = player 2 wins, 'D' = Draw)  
ret
evaluator endp 
                
declareWinner proc near 
     
    call revealInputs
    
    ;Game over string
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, declareResultHeader
    Mov CX, 11 
    Mov DH, 21
    Mov DL, 0 
    Int 10H
    
    Mov DH, gameResult
    
    cmp DH, 'D'
    JNE notD 
                
        ;Prints its A draw
        Mov AH, 13H
        Mov AL, 01
        Mov BH, 00
        Mov BL, 07H
        Lea BP, draw
        Mov CX, 11 
        Mov DH, 21
        Mov DL, 12 
        Int 10H
        ret
       
    notD:
    cmp DH, '1'
    JNE not1
    
        ;Player 1 Wins
        Mov AH, 13H
        Mov AL, 01
        Mov BH, 00
        Mov BL, 07H
        Lea BP, winner1
        Mov CX, 32 
        Mov DH, 21
        Mov DL, 12 
        Int 10H
        ret
    
    not1: 
    
    ;Player 2 Wins
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, winner2
    Mov CX, 32 
    Mov DH, 21
    Mov DL, 12 
    Int 10H   

ret
declareWinner endp
    
revealInputs proc near
   
    ;Player 1
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, player1
    Mov CX, 10 
    Mov DH, 18
    Mov DL, 5 
    Int 10H 
    
    ;Reveal its input
    Mov AH, 0AH 
    Mov AL, player1Input 
    Mov BH, 0 
    Mov BL, 1
    Mov CX, 1 
    Int 10H
    
    ;Player 2
    Mov AH, 13H
    Mov AL, 01
    Mov BH, 00
    Mov BL, 07H
    Lea BP, player2
    Mov CX, 10 
    Mov DH, 19
    Mov DL, 5 
    Int 10H 
    
    ;Reveal its input
    Mov AH, 0AH 
    Mov AL, player2Input 
    Mov BH, 0 
    Mov BL, 1
    Mov CX, 1 
    Int 10H 
   
ret
revealInputs endp