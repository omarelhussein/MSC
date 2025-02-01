// save a number (e. g. 5) to RAM[0]
@5
D = -A
@0
M = D

@R0
D = M

@GTD // greater than D
D;JGT

@0      // Put 0 in D
D=A     // D = 0
@1      // Select RAM[1]
M=D     // RAM[1] = 0

@DONE
0;JMP

(GTD)
@1
D = A
@1
M = D

(DONE)