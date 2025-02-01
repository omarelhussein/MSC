(START)
@SCREEN
D=A
@15          // Start 15 positions to the right for 16 bits
D=D+A        // Now points to rightmost position
@screenPos   // Current screen position
M=D

@R0
D=M
@number      // Store the number to convert
M=D

// Main drawing
@i           // Bit counter
M=0
@1
D=A
@testBit     // Start from right
M=D

(CONVERT_LOOP)
@i
D=M
@16
D=D-A
@CHECK_KEY   // If we've drawn all 16 bits, check keyboard
D;JGE

// Test current bit
@number
D=M
@testBit
D=D&M       // Bit AND operation
@DRAW_ZERO
D;JEQ       // If result is 0, draw zero

// Draw One 16x16 pixels, filled black square
@screenPos
D=M
@drawPos
M=D

@16
D=A
@rowCount
M=D

(DRAW_ONE_LOOP)
@rowCount
D=M
@ONE_DONE
D;JLE

@drawPos
A=M
M=-1 // draw black

@drawPos
D=M
@32  // Move to next row (32 words = 512 pixels)
D=D+A
@drawPos
M=D

@rowCount
M=M-1
@DRAW_ONE_LOOP
0;JMP

(ONE_DONE)
@NEXT_BIT
0;JMP

// Draw Zero
(DRAW_ZERO)
@screenPos
D=M
@drawPos
M=D

@16
D=A
@rowCount
M=D

(DRAW_ZERO_LOOP)
@rowCount
D=M
@ZERO_DONE
D;JLE

// First or last row?
@rowCount
D=M
@16
D=D-A       // First row?
@DRAW_OUTLINE
D;JEQ

@rowCount
D=M
@1
D=D-A       // Last row?
@DRAW_OUTLINE
D;JEQ

// Middle row - just edges
@drawPos
A=M
M=1
@NEXT_ROW
0;JMP

(DRAW_OUTLINE)
@drawPos
A=M
M=1

(NEXT_ROW)
@drawPos
D=M
@32 // next row
D=D+A
@drawPos
M=D

@rowCount
M=M-1
@DRAW_ZERO_LOOP
0;JMP

(ZERO_DONE)

(NEXT_BIT)
// Move test bit left
@testBit
D=M
M=D+M

@screenPos
D=M
M=M-1

@i
M=M+1
@CONVERT_LOOP
0;JMP

// Check keyboard input
(CHECK_KEY)
@KBD
D=M
@85// ASCII code for 'U'
D=D-A
@INCREMENT
D;JEQ

@CHECK_KEY
0;JMP

// Increment number and restart
(INCREMENT)
@KBD
D=M
@INCREMENT  // Wait for key release
D;JNE

@R0
M=M+1
@START
0;JMP