; enter - void
; exit - move to graffic  mode
callGraffic macro 
	mov ax, 13h
	int 10h
endm
; enter - void
; exit - return to text mode
retText macro 
	push ax
	mov ax, 3
	int 10h
	pop ax
endm
; enter - x: value of x of a key to print
; exit - print white key

print_key macro place_x
	mov [x], place_x
	;↑ mov x requested to var x	
	mov [y],45			; y will always be 45 so all the keys will have the same starting point
	mov [len],40		; length will always be 40 so all the keys will have the same length
	mov [height],130	; height will always be 130 so all the keys will have the same height
	call print			; prints the key with requested x
endm
; enter - void
; exit - turn sound on
sound_on macro
        in al, 61h
        or al, 00000011b
        out 61h, al 
endm
; enter - void
; exit - turn sound off
sound_off macro
        in al, 61h
        and al, 11111100b
        out 61h, al
endm 

jumps
IDEAL
MODEL small
STACK 100h
DATASEG
; ———————————
; Your variables here
	x 			dw ?			; value of x
	y 			dw ?			; value of y
	color 		db 15			; color (starts with white)
	len 		dw ?			; length of key
	height 		dw ?			; height of key
	note 		dw ?			; value of the frequency of the note
    inst_line 	db 13,10  		; instructions
              	db '         keys: a, s, d, f, g, h',13, 10
              	db '          press esc for escape$', 13,10
	see_you 	db 'see you later$',13, 10 ; goodbye msg
; ———————————
CODESEG
; enter - x , y (for dot)
; exit - prints a dot on requested x, y
proc drawPixel
	push cx ax
	mov bh, 0h 		; screen
	mov cx, [x] 	; value of x (dot)
	mov dx, [y] 	; value of y (dot)
	mov al, [color] ; color of the dot
	mov ah, 0ch		; print pixel
	int 10h
	pop ax cx
	ret
endp drawPixel
; enter - length of key
; exit - prints line from x + requested length
proc drawLine
   push cx
   mov cx,[len]			; mov the length of key requested for the loop
   pixelLoop:			
        call drawPixel	; call drawpixel to draw pixel on requested value of x
        inc [x]			; increse value of x to go right and create a line
        loop pixelLoop	; loop until length (cx) is 0
	pop cx
    ret
endp drawLine
; enter - height of key
; exit - prints whole key
proc print
    push cx si [x] [y] [len] [height]
	mov cx,[height]		; mov the height key requested for the loop
	mov si,[len]		; mov the length of the line into SI
	lineLoop:
		call drawLine	; call drawline to draw pixel on requested value of x,y
		inc [y]			; move to the next line by increasing Y position
		sub [x],si		; reset X position back to its original value
		loop lineLoop
	pop [height] [len] [y] [x] si cx
	ret
endp print
; enter - frequency of note
; exit - plays sound
proc playnote
	sound_on            ; turn speaker on
	mov ax,[note]       ; load note freq
	out 42h,al          ; low byte
	mov al,ah           ; high byte
	out 42h,al          
	ret                 
endp playnote
; --------------------------
; Your code here

	start:
	mov ax, @data
	mov ds, ax

	; graphic mode
	callGraffic
    mov dx, offset inst_line 	; prints inst_line
    mov ah, 9h
    int 21h
    ;white keys
	print_key 25 		; call for macro to print first key in (25, 45)
	print_key 70 		; + 45 to x for each key
	print_key 115
	print_key 160
	print_key 205
	print_key 250

WaitForData:
	in al, 64h 			; read keyboard status port
	cmp al, 10b 		; data in buffer?
	je WaitForData		; waits until data availble
	in al, 60h 			; gets keyboard data 
	cmp al, 1h 			; is it esc key?
	je escape			; jmps for esc if so

    	; checks for first white key
        cmp al, 01eh 	; cmp to 'a'
        je do			; jmps to do key if equals
		cmp al, 09eh	; cmp to leaving 'a'
		je do2			; jmps to do2 if equals
        ;checks for second white key
        cmp al, 01fh	; cmp to 's' 
        je re			; jmps to re key if equals
		cmp al, 09fh	; cmp to leaving 's'
		je re2			; jmps to re2 if equals
        ;checks for third white key
        cmp al, 20h		; cmp to 'd'
        je mi			; jmps to mi key if equals
		cmp al, 0a0h	; cmp to leaving 'd'
		je mi2			; jmps to mi2 if equals
        ;checks for fourth white key
        cmp al, 21h		; cmp to 'f'
        je fa			; jmps to fa key if equals
		cmp al, 0a1h	; cmp to leaving 'f'
		je fa2			; jmps to fa2 if equals
        ;checks for fifth white key
        cmp al, 22h		; cmp to 'g'
        je sol			; jmps to sol key if equal
		cmp al, 0a2h	; cmp to leaving 'g'
		je sol2			; jmps to sol2 if equal
        ;checks for sixth white key
        cmp al, 23h		; cmp to 'h'
        je la			; jmps to la key if equals
		cmp al, 0a3h	; cmp to 'h'
		je la2			; jmps to la2 if equals

jumpWait:
	jmp WaitForData ; jmp for waitfordata to not go stright to do key

escape:
	retText 				; return to text mode
	mov dx, offset see_you	; gets offset of see_you msg
	mov ah, 9h
	int 21h					; print msg
	jmp exit				; jmps out of the program

    do: 
		mov [color], 4h		; colors : red
		print_key 25		; colors the first key in red when pressed 'a'
		mov [note], 4560	; freq of note
		call playnote		; plays the note with proc playnote
		jmp WaitForData		; jmps back to waitfordata for new data
	do2:
		mov [color], 15		; color: white
		print_key 25		; prints the first key in white when leaving 'a'
		sound_off			; turns off sound
		jmp WaitForData		; jmps back to waitfordata for new data
    re:
		mov [color], 41		; color: orange
		print_key 70		; colors the second key in orange when pressed 's'
		mov [note], 4061	; freq of note
		call playnote		; plays the note with proc playnote
		jmp WaitForData		; jmps back to waitfordata for new data
	re2:
		mov [color], 15		; color: white
		print_key 70		; prints the second key in white when leaving 's'
		sound_off			; turns off sound
		jmp WaitForData		; jmps back to waitfordata for new data
    mi:
		mov [color], 14		; color: yellow
		print_key 115		; colors the third key in yellow when pressed 'd'
		mov [note], 3615   	; freq of note
		call playnote      	; plays the note with proc playnote
		jmp WaitForData		; jmps back to waitfordata for new data
	mi2:
		mov [color], 15		; color: white
		print_key 115		; prints the third key in white when leaving 'd'
		sound_off			; turns off sound
		jmp WaitForData		; jmps back to waitfordata for new data
    fa: 
		mov [color], 2h		; color: green
		print_key 160		; colors the fourth key in green when pressed 'f'
		mov [note], 3413   	; freq of note
		call playnote      	; plays note with proc playnote
		jmp WaitForData		; jmps back to waitfordata for new data
	fa2:
		mov [color], 15		; color: white
		print_key 160		; prints the fourth key in white when leaving 'f'
		sound_off			; turns off sound
		jmp WaitForData		; jmps back to waitfordata for new data
    sol:
		mov [color], 3h		; color: light blue
		print_key 205		; colors the fifth key in blue when pressed 'g'
		mov [note], 3047   	; freq of note
		call playnote      	; plays note with proc playnote
		jmp WaitForData		; jmps back to waitfordata for new data
	sol2:
		mov [color], 15		; color: white
		print_key 205		; prints fifth key in white when leaving 'g'
		sound_off			; turns off sound
		jmp WaitForData		; jmps back to waitfordata for new data
    la: 
		mov [color], 1h		; color: blue
		print_key 250		; colors the sixth key in blue when pressed 'h'
		mov [note], 2712   	; freq of note
		call playnote      	; plays note with proc playnote
		jmp WaitForData		; jmps back to waitfordata for new data
	la2:
		mov [color], 15		; color: white
		print_key 250		; prints sixth key in white when leaving 'h'
		sound_off			; turns off sound
		jmp WaitForData		; jmps back to waitfordata for new data
; ———————————

exit:
	mov ax, 4c00h
	int 21h
END start