// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//	state = 0;	// 0 -> clear; else -> filled
//	n = 8192	// 512 (px width) / 16 = 32 -> 32 16-bit registers for one row
//				// 32 * 256 (px vertically) = 8192
//				// screen memory map -> [SCREEN, SCREEN + 8192[
//  (KBDLOOP)
//	loop {
//		if (RAM[KBD] == 0) goto CLEAR;
//		else goto FILL;
//	}
//
//	(CLEAR)
//	if (state == 0) goto KBDLOOP;
//	for (i = 0; i < n; i++) {
//		RAM[SCREEN + i] = 0;
//	}
//	state = 0;
//  goto KBDLOOP;
//
//	(FILL)
//	if (state != 0) goto KBDLOOP;
//	for (i = 0; i < n; i++ {
// 		RAM[SCREEN + i] = -1;	// -1 -> 111111111111111
//	}
//	state = 1;
//	goto KBDLOOP;

	@state
	M=0		// state = 0;

	@8192
	D=A
	@n
	M=D		// n = 8192;


(KBDLOOP)
	@KBD
	D=M
	@CLEAR
	D;JEQ	// if (RAM[KBD] == 0) goto CLEAR;
	
	@FILL
	0;JMP	// else goto FILL;


(CLEAR)
	@state
	D=M
	@KBDLOOP
	D;JEQ	// if (state == 0) goto KBDLOOP;

	@i
	M=0		// i = 0;

(CLEARLOOP)
	@i
	D=M
	@n
	D=M-D	// n - i;
	@CLEAREND
	D;JEQ	// if (n - i == 0) goto CLEAREND;

	@SCREEN
	D=A
	@i
	A=D+M	// SCREEN + i;
	M=0		// RAM[SCREEN + i] = 0;

	@i
	M=M+1	// i++;
	@CLEARLOOP
	0;JMP	// goto CLEARLOOP;

(CLEAREND)
	@state
	M=0		// state = 0;
	@KBDLOOP
	0;JMP	// goto KBDLOOP;

(FILL)
	@state
	D=M
	@KBDLOOP
	D;JNE	// if (state != 0) goto KBDLOOP;

	@i
	M=0		// i = 0;

(FILLLOOP)
	@i
	D=M
	@n
	D=M-D	// n - i;
	@FILLEND
	D;JEQ	// if (n - i == 0) goto FILLEND;

	@SCREEN
	D=A
	@i
	A=D+M	// SCREEN + i;
	M=-1	// RAM[SCREEN + i] = -1;

	@i
	M=M+1	// i++;
	@FILLLOOP
	0;JMP	// goto FILLLOOP;

(FILLEND)
	@state
	M=1		// state = 1;
	@KBDLOOP
	0;JMP	// goto KBDLOOP;
