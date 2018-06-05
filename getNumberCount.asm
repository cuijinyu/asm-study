data segment
	ARRAY dw 0,1,2,3,4,-1,2,4,5,-9
	len dw 10	;数组长度
	np dw 0	;	正数数量
	nn dw 0	;	负数数量
	nz dw 0	;	零的数量
data ends

stack segment

stack ends

code segment
	assume cs:code,ds:data,ss:stack
start:
	mov ax,data
	mov ds,ax
	
	mov cx,len
	mov si,0	;	source array index
	mov bx,0	;	positive array index
	mov di,0	;	negative array index
xy:
	mov ax,ARRAY[si]
	cmp ax,0
	jg positive
	jl negative
	inc nz
	jmp loopx
positive:
	add bx,2
	inc np
	jmp loopx
negative:
	add di,2
	inc nn
loopx:
	add si,2
	loop xy
display:
	mov bx,np
	add bx,48
	mov dx,bx
	mov ah,02h
	int 21h
	mov bx,nn
	add bx,48
	mov dx,bx
	mov ah,02h
	int 21h
	mov bx,nz
	add bx,48
	mov dx,bx
	mov ah,02h
	int 21h
	
	mov ah,4ch	;	返回dos系统
	int 21h
	
	ret
code ends
	end start
	
	