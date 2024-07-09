// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//	m = RAM[0]
//	n = RAM[1]
//	product = 0
//	for (i = 0; i < m; i++) {
//		product = product + n;
//	}
//	RAM[2] = product

	@R0
	D=M
	@m
	M=D	// m = RAM[0]

	@R1
	D=M
	@n
	M=D	// n = RAM[1]

	@0
	D=A
	@R2
	M=D	// product = 0

	@i
	M=D	// i = 0

(LOOP)
	@m
	D=M
	@i
	D=D-M	// m - i
	@END
	D;JEQ	// if (m - i == 0) goto STORE

	@n
	D=M
	@R2
	M=D+M	// product = product + n

	@i
	D=M
	M=D+1

	@LOOP	// goto LOOP
	0;JMP

(END)
	@END
	0;JMP