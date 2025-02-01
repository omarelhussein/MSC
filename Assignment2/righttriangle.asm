@SCREEN
D=A

@address
M=D

@40 // move 40 pixels to right
D=A
@margin_left
M=D

@address
// add the pixels to the right
M=M+D

@2048 // half-of-center (1/4)
D=A
@margin_top
M=D

@address
// then add the pixels to top
M=M+D
D=M

@hypotenuse_address
M=D

@110 // pixels height line
D=A
@height_line
M=D

// start drawing the height line
(LOOP_HEIGHT_LINE)
@address
A=M
M=1

@32
D=A
@address
M=M+D

@height_line
M=M-1
D=M

@LOOP_HEIGHT_LINE
D@JGE

@6
D=A
@baseline
M=D

@address
D=M

@baseline_address
M=D

@crossline_address
M=D
// end drawing the height line

// start drawing the baseline
(LOOP_BASELINE)
@baseline_address
A=M
M=-1

@baseline_address
M=M+1

@baseline
M=M-1
D=M

@LOOP_BASELINE
D;JGE

@53
D=A
@crossline
M=D

@1
D=A
@crossline_draw_position
M=D
// end drawing the baseline

// start drawing the crossline
(LOOP_CROSSLINE)
@crossline_draw_position
D=M
@crossline_address
A=M
D=M|D
M=D

@32
D=-A
@crossline_address
M=M+D

@crossline_draw_position
D=M
@0
A=D
D=D+A
@crossline_draw_position
M=D

@crossline_draw_position
D=M
@RESET_CROSSLINE
D;JEQ

@crossline
M=M-1
D=M

@LOOP_CROSSLINE
D;JGT

@END_CROSSLINE
0;JMP

(RESET_CROSSLINE)
@1
D=A
@crossline_draw_position
M=D

@crossline_address
M=M+1

@crossline
D=M
@LOOP_CROSSLINE
0;JMP

(END_CROSSLINE)
// end drawing the crossline

// start drawing the hypotenuse
@105
D=A
@hypotenuse_line//line size e. g. 16pixel, works also as counter for loop
M=D

@1
D=A
@pixel_draw_position//the position to draw, works like a draw pattern
M=D

(LOOP_HYPOTENUSE)
@pixel_draw_position
D=M
@hypotenuse_address//defined above, used to identify where to start drawing, skipping rows, etc.
A=M
D=M|D
M=D

@32 // moves down a line. 32 is parallel line (next row), 16 is half row, and so on.
D=A

@hypotenuse_address
M=M+D

// shifting
@pixel_draw_position
D=M
@0
A=D
D=D+A
@pixel_draw_position
M=D

@pixel_draw_position
D=M
@RESET
D;JEQ

@hypotenuse_line
M=M-1
D=M

@LOOP_HYPOTENUSE
D;JGT

@END
0;JMP

(RESET)
@1
D=A
@pixel_draw_position
M=D

@hypotenuse_address
M=M+1// Move one word right

@hypotenuse_line
D=M
@LOOP_HYPOTENUSE
0;JMP

(END)
@END
0;JMP
// end drawing the hypotenuse