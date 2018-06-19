data segment
	file db 'a\text.txt',0
	buf db 100,?,100 dub(?)
	fh dw ?

	copyfile db 'a\copytext.txt',0
	copyfh dw ?
	error_msg db 0dh,0ah,'error','$'

data ends

stack segment stack
	dw 20h dup(?)
	top label word
stack ends

code segment 
	assume ds:data,cs:code,ss:stack
	;read file 
	mov ah,3fh
	mov bx,fh
	mov cx,512
	lea lea,buf
	int 21h
	jc error
	cmp ax,0
	je exit
	
error:
	lea dx,error_msg
	mov ah,09h
	int 21h
	
exit:
	mov ah,4ch
	int 21h
	
code ends
