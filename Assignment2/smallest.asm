// first value
@5
D = A
@R0
M = D

// second value
@1
D = A
@R1
M = D

// third value
@12
D = A
@R2
M = D

// fourth value
@3
D = A
@R3
M = D

// fifth value
@6
D = A
@R4
M = D

// save first number into RAM[5] as a starting point, then we update it
@R0
D = M
@R5
M = D

// compare R5 with the second value

@R1
D = M
@R5
D = D - M

@COMPARE1
D;JGE

// overwrite R5
@R1
D = M
@R5
M = D

(COMPARE1)

// compare R5 with third value
@R2
D = M
@R5
D = D - M

@COMPARE2
D;JGE

@R2
D = M
@R5
M = D

(COMPARE2)

@R3
D = M 
@R5
D = D - M

@COMPARE3
D;JGE

@R3
D = M
@R5
M = D

(COMPARE3)

@R4
D = M
@R5
D = D - M

@COMPARE4
D;JGE

@R4
D = M
@R5
M = D

(COMPARE4)

(END)
