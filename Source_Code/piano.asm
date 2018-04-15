ORG 7c00h ; Permet de faire une partition bootable      

MOV AH, 0h   
MOV AL, 13h ; mode video 320*200 256 couleurs
INT 10h     ; Permet l'affichage

JMP InitCouleurTouche ;On commence par l'affichage des touches


;;;;;;;;;; Les differentes notes de musiques ;;;;;;;;;

DO_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 4561   ; 1193180 / Frequence
    JMP JAMBON

REB_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 4304   ; 1193180 / Frequence
    JMP JAMBON

RE_NOTE:
    MOV AL,182
    OUT 43h,AL
    MOV AX, 4062   ; 1193180 / Frequence
    JMP JAMBON

MIB_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 3835   ; 1193180 / Frequence
    JMP JAMBON

MI_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 3620   ; 1193180 / Frequence
    JMP JAMBON

FA_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 3416   ; 1193180 / Frequence
    JMP JAMBON

SOLB_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 3224   ; 1193180 / Frequence
    JMP JAMBON

SOL_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 3044   ; 1193180 / Frequence
    JMP JAMBON     

LAB_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 2873   ; 1193180 / Frequence
    JMP JAMBON
    
LA_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 2712   ; 1193180 / Frequence
    JMP JAMBON

SIIB_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 2559   ; 1193180 / Frequence
    JMP JAMBON
    
SII_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 2415   ; 1193180 / Frequence
    JMP JAMBON

DO_PLUS_NOTE:
    MOV AL, 182
    OUT 43h, AL
    MOV AX, 2281   ; 1193180 / Frequence
    JMP JAMBON
    

JAMBON:              ; fonction qui permet de faire un son
    OUT 42h, AL
    MOV AL, AH
    OUT 42h, AL
    IN  AL, 61h
    OR  AL, 11b
    OUT 61h, AL 
    
    MOV CX, 15
    MOV DX, 0
    MOV AH, 86h
    INT 15h          ; permet de jouer la note pendant environ 1 seconde
    IN  AL, 61h
    AND AL, 11111100b
    OUT 61h, AL 
    
    JMP READ_KEY 
    
    
;;;;;;;; Affichage des touches blanches ;;;;;;;;
;;; l'affichage fonctionne avec un systeme de plateau a deux dimensions;
;;; cx = l'axe des abscisses et dx = l'axe des ordonnees ;;; 

InitCouleurTouche:
    MOV AL, 1111b ; couleur (1111b = blanc) 
    MOV BH, 0h   
    
    MOV AH, 0ch  ; fonction afficher pixel  
    MOV AL, 1111b
    MOV CX, 20d   ;on definit ou on commence notre fonction 
    MOV DX, 20d
    JMP Coloriage


;;;; une fois la colonne peinte, il faut faire la meme chose mais decale d'un pixel vers la droite;;;; 
    
ReinitLigne:        
    INC CX
    MOV DX, 20d
    JMP Coloriage


;;;; les comparaisons permettent de ne pas dessiner pendant deux pixels;;
;;;; et cela permet donc de definir visuellement les touches;;;     
Coloriage:         
    CMP CX, 51d
    JE ReinitLigne
    CMP CX, 52d
    JE ReinitLigne
    
    CMP CX, 83d
    JE ReinitLigne
    CMP CX, 84d
    JE ReinitLigne
    
    CMP CX, 115d
    JE ReinitLigne
    CMP CX, 116d
    JE ReinitLigne
    
    CMP CX, 147d
    JE ReinitLigne
    CMP CX, 148d
    JE ReinitLigne
    
    CMP CX, 179d
    JE ReinitLigne
    CMP CX, 180d
    JE ReinitLigne
    
    CMP CX, 211d
    JE ReinitLigne
    CMP CX, 212d
    JE ReinitLigne
    
    CMP CX, 243d
    JE ReinitLigne
    CMP CX, 244d
    JE ReinitLigne
    
    CMP CX, 275d
    JE InitCouleurToucheNoire1  ;une fois les touches blanches finies, on va vers l'affichage des touches noires;
      
    INC DX
    INT 10h      ; int 10 = affichage
    
    CMP DX, 100d
    JE ReinitLigne
    
    JMP Coloriage


;;;;;;;; Affichage touches noires ;;;;;;;;
;; chaque touche noire a un debut unique
;donc, une initialisation par touche
InitCouleurToucheNoire1: 
    MOV CX, 40d
    MOV DX, 20d
    JMP ColoriageNoire
    
InitCouleurToucheNoire2: 
    MOV CX, 72d
    MOV DX, 20d
    JMP ColoriageNoire

InitCouleurToucheNoire3: 
    MOV CX, 136d
    MOV DX, 20d
    JMP ColoriageNoire

InitCouleurToucheNoire4: 
    MOV CX, 168d
    MOV DX, 20d
    JMP ColoriageNoire

InitCouleurToucheNoire5: 
    MOV CX, 200d
    MOV DX, 20d
    JMP ColoriageNoire


; meme principe que pour les touches blanches
ReinitLigneNoire:
    INC CX
    MOV DX, 20d
    JMP ColoriageNoire

;;; meme systeme que pour les touches blanches;;;    
ColoriageNoire:        
    MOV AL, 0000b ; (0000b = pixel noir) 
    MOV BH, 0h  ; page ecran 
    
    MOV AH, 0ch  ; fonction affichage pixel
             
    CMP CX, 62d
    JE InitCouleurToucheNoire2
    
    CMP CX, 94d
    JE InitCouleurToucheNoire3
    
    CMP CX, 158d
    JE InitCouleurToucheNoire4
    
    CMP CX, 190d
    JE InitCouleurToucheNoire5
    
    CMP CX, 222d
    JE READ_KEY 
      
    INC DX
    INT 10h
    
    CMP DX, 60d
    JE ReinitLigneNoire
    
    JMP ColoriageNoire


;;;;;; READ THE ******* KEYS ;;;;;; 
; faire une comparaison avec une inegalite est plus optimise
; car cela permet de faire un jump inconditionnel apres
READ_KEY:
    MOV AH, 0    
    INT 16H      ; int 16h = attend une l'appui d'une touche
    
    CMP AL, 's'     ; compare la touche appuye
    JNE READ_KEY1   
    JMP DO_NOTE

READ_KEY1:
    CMP AL, 'e'     
    JNE READ_KEY2
    JMP REB_NOTE

READ_KEY2:
    CMP AL, 'd'     
    JNE READ_KEY3
    JMP RE_NOTE 

READ_KEY3:
    CMP AL, 'r'     
    JNE READ_KEY4
    JMP MIB_NOTE
    
READ_KEY4:
    CMP AL, 'f'     
    JNE READ_KEY5
    JMP MI_NOTE
    
READ_KEY5:   
    CMP AL, 'g'     
    JNE READ_KEY6
    JMP FA_NOTE 

READ_KEY6: 
    CMP AL, 'y'     
    JNE READ_KEY7
    JMP SOLB_NOTE
    
READ_KEY7:     
    CMP AL, 'h'     
    JNE READ_KEY8
    JMP SOL_NOTE  

READ_KEY8: 
    CMP AL, 'u'     
    JNE READ_KEY9
    JMP LAB_NOTE
    
READ_KEY9:     
    CMP AL, 'j'     
    JNE READ_KEY10
    JMP LA_NOTE

READ_KEY10:
    CMP AL, 'i'     
    JNE READ_KEY11
    JMP SIIB_NOTE
    
READ_KEY11:  
    CMP AL, 'k'     
    JNE READ_KEY12
    JMP SII_NOTE
    
READ_KEY12:     
    CMP AL, 'l'
    JNE READ_KEY13
    JMP DO_PLUS_NOTE 

READ_KEY13:     
    CMP AL, 'x'
    JNE READ_KEY
    JMP RELOAD
    
RELOAD:        ; recharge l'ecran
    INT 19h 