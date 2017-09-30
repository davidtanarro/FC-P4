/* Ejercicio 2 (a desarrollar en casa)
   Comentad completamente la siguiente subrutina, e implementad una equivalente en C en el fichero trafo.c


	.global rgb2gray

	.equ COEF1, 3483
	.equ COEF2, 11718
	.equ COEF3, 1183

	.text

rgb2gray:
  		ldr r3, =COEF1
  		mul r0, r3, r0
  		ldr r3, =COEF2
  		mla r0, r3, r1, r0
  		ldr r3, =COEF3
  		mla r0, r3, r2, r0
  		mov r0, r0, lsr #14

  		mov pc, lr
*/

/* Ejercicio 3 (a desarrollar en casa)
   Completar la subrutina RGB2GrayMatrix. Recordad que debéis comentar antes la función RGB2GrayMatrix en el fichero trafo.c
*/
	.global RGB2GrayMatrix

	.equ N, 128
	.equ M, 128
	
RGB2GrayMatrix:
		push {r4-r10,fp,lr}
		add fp,sp,#32	@ 32 = 4*9-4

		mov r6, r0		@ dir(orig[][])
		mov r7, r1		@ dir(dest[][])
		mov r4,#0		@ i = 0
		for1: cmp r4,#N
			bge fin_for1
			mov r5,#0	@ j = 0
			for2: cmp r5,#M
				bge fin_for2
				ldr r9, =M	@ r9 <- M
				mla r8,r4,r9,r5	@ r8 <- i*M+j
				mov r9,#3	@ r9 <- 3
				mov r10,r8	@ En mul Rd y Rm deben de ser diferentes
				mul r8,r10,r9	@ r8 <- (i*M+j)*3
				ldrb r0,[r6,r8]	@ r8 <- orig[i][j].R
				
				add r8,r8,#1	@ r8 <- (i*M+j)*3 + 1
				ldrb r1,[r6,r8]	@ r8 <- orig[i][j].G
				
				add r8,r8,#1	@ r8 <- (i*M+j)*3 + 2
				ldrb r2,[r6,r8]	@ r8 <- orig[i][j].B
				bl rgb2gray
				strb r0,[r7]	@ dest[i][j] =  rgb2gray(orig[i][j].R, orig[i][j].G, orig[i][j].B);
				add r7,r7,#1	@ dir(dest[][])+1byte
				add r5,r5,#1	@ j++
				b for2
			fin_for2:
			add r4,r4,#1	@ i++
			b for1
		fin_for1:
		
		pop {r4-r10,fp,lr}
		bx lr
/*
void contarBlancos(unsigned char mat[N][M], unsigned char vector[N]) {
    int i,j;

    for (i=0;i<N;i++) {
        vector[i]=0;
        for (j=0; j<M; j++) {
            if ( mat[i][j] == 255) vector[i]++;
        }
    }
}
*/
.global contarBlancos

	.equ N, 128
	.equ M, 128

contarBlancos:
		mov r4,#0		@ i = 0
		for11: cmp r4,#N
			bge fin_for11
			mov r5,#0	@ j = 0
			strb r5,[r1,r4] @ vector[i]=0;
			for22: cmp r5,#M
				bge fin_for22

				ldr r9, =M	@ r9 <- M
				mla r8,r4,r9,r5	@ r8 <- i*M+j
				ldrb r6,[r0,r8]
				if: cmp r6,#255
					bne fin_if
					ldrb r7,[r1,r4]
					add r7,r7,#1
					strb r7,[r1,r4]
				fin_if:

				add r5,r5,#1	@ j++
				b for22
			fin_for22:
			add r4,r4,#1	@ i++
			b for11
		fin_for11:
		bx lr

  		.end


