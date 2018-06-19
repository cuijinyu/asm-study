data segment
	file db 'text.txt',0
	buf db 100 dup(?)
	fh dw ?

	copyfile db 'copytext.txt',0
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
	lea dx,buf
	int 21h
	jc error
	cmp ax,0
	mov fh,ax
	je exit
	
write:
	;create file
	mov ah,3ch
	mov cx,00
	lea dx,copyfile
	int 21h
	jc error
	;write to the file
	mov ax,fh
	mov bx,2
	div bx
	mov cx,ax
	mov ah,40h
	mov bx,copyfh
	lea dx,buf
	int 21h
	jc error
	jmp exit
	
	
error:
	lea dx,error_msg
	mov ah,09h
	int 21h
	
exit:
	mov ah,4ch
	int 21h
	
code ends
end
