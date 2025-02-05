@SCREEN
D=A
@address
M=D

//create space for border of clock
@11
D=A
@address
M=M+D
// move address from top to bottom, each 32 "words" (32*16 pixels) = 1 row (1 line down)
// 1024 will move 32 rows down
@1024
D=A
@address
M=M+D

@address
D=M

// store the start address to make drawing easier
@startaddress
M=D

// draw first top line
@9
D=A
@linecounter
M=D

(TOP_LINE)
// we draw the top line using 16 pixels steps (M=-1)
@address
A=M
M=-1
// move to the next pixel
@address
M=M+1
// decrease the line counter so we know when to stop
@linecounter
M=M-1
// if line counter is not zero, we continue drawing. We need to set D to pass the JGE test
D=M

@TOP_LINE
D;JGE

// draw the right line
@160
D=A
@linecounter
M=D

(RIGHT_LINE)
@1
D=A
@address
A=M
M=D|M

@32
D=A
@address
M=M+D

@linecounter
M=M-1
D=M

@RIGHT_LINE
D;JGE

// draw left line using the start address to go back to the top
@160
D=A
@linecounter
M=D

(LEFT_LINE)
// pixel position to draw from address
@1
D=A
@startaddress
A=M
M=D|M

@32
D=A
@startaddress
M=M+D

@linecounter
M=M-1
D=M

@LEFT_LINE
D;JGE

// continue with the bottom line from the end of the right line
@9
D=A
@linecounter
M=D

(BOTTOM_LINE)
@1
D=-A
@startaddress
A=M
M=D|M

@startaddress
M=M+1

@linecounter
M=M-1
D=M

@BOTTOM_LINE
D;JGE

// draw the clock face

// 12 o'clock
@SCREEN
D=A
@clock12address
M=D

@16
D=A
@clock12address
M=M+D

//1024 to move 32 rows down (previous value on initial address) + a bit more to move from the border
@1056
D=A
@clock12address
M=M+D

@clock12address
D=M

@clock1address
M=D
@clock2address
M=D
@clock3address
M=D
@clock4address
M=D
@clock5address
M=D
@clock6address
M=D
@clock7address
M=D
@clock8address
M=D
@clock9address
M=D
@clock10address
M=D
@clock11address
M=D

// hands
@smallhandaddress
M=D
@bighandaddress
M=D

// length of the 12 o'clock line
@16
D=A
@counter12
M=D

(CLOCK12)
@1
D=A
@clock12address
A=M
M=D|M

@32
D=A

@clock12address
M=M+D

@counter12
M=M-1
D=M

@CLOCK12
D;JGE

// 3 o'clock
@3
D=A
@clock3address
M=D+M

// push the line to the bottom
@2560
D=A
@clock3address
M=M+D

@1
D=A
@screenpixel
M=D

@8
D=A
@counter3
M=D

(CLOCK3)
@clock3address
A=M
M=-1

@counter3
M=M-1
D=M

@CLOCK3
D;JGE

// 9 o'clock
@4
D=-A
@clock9address
M=D+M

// push the line to the bottom
@2560
D=A
@clock9address
M=M+D

@1
D=A
@screenpixel
M=D

@8
D=A
@counter9
M=D

(CLOCK9)
@clock9address
A=M
M=-1

@counter9
M=M-1
D=M

@CLOCK9
D;JGE

// 6 o'clock
@4608
D=A
@clock6address
M=M+D

// length of the 6 o'clock line
@16
D=A
@counter6
M=D

(CLOCK6)
@1
D=A
@clock6address
A=M
M=D|M

@32
D=A

@clock6address
M=M+D

@counter6
M=M-1
D=M

@CLOCK6
D;JGE

// 11 o'clock
@2
D=A
@clock11address
M=M-D

@clock11address
D=M

@1
D=A
@screenpixel
M=D

@8
D=A
@counter11
M=D

@768
D=A
@clock11address
M=M+D


(CLOCK11)
@screenpixel
D=M
@clock11address
A=M
M=D|M

@32
D=A
@clock11address
M=M+D

@screenpixel
D=M
M=M+D

@counter11
M=M-1
D=M

@CLOCK11
D;JGE

//1 o'clock
@2
D=A
@clock1address
M=D+M

@clock1address
D=M

@1
D=A
@screenpixel
M=D

@8
D=A
@counter1
M=D

@1024
D=A
@clock1address
M=M+D

(CLOCK1)
@screenpixel
D=M
@clock1address
A=M
M=D|M

@32
D=A
@clock1address
M=M-D

@screenpixel
D=M
M=M+D

@counter1
M=M-1
D=M

@CLOCK1
D;JGE

//2 o'clock
@4
D=A
@clock2address
M=D+M

// push the line to the bottom
@1567
D=A
@clock2address
M=M+D

@8
D=A
@counter2
M=D

@clock2address
D=M

@1
D=A
@screenpixel
M=D

@1
D=A
@pattern1
M=D
@2
D=A
@pattern2
M=D
 
(CLOCK2)
@screenpixel
D=M
@clock2address
A=M
M=D|M

@pattern1
D=M
@PATTERN1C
D;JLE

@pattern2
D=M
@PATTERN2C
D;JLE

@32
D=-A
@clock2address
M=M+D

@pattern1
M=M-1
@pattern2
M=M-1

@CONTINUE2
0;JMP

(PATTERN1C)
@1
D=A
@pattern1
M=D
@CONTINUE2
0;JMP

(PATTERN2C)
@2
D=A
@pattern2
M=D

(CONTINUE2)
@screenpixel
D=M
M=M+D

@counter2
M=M-1
D=M

@CLOCK2
D;JGE

// 10 o'clock
@2
D=-A
@clock10address
M=D+M

// push the line to the bottom
@1567
D=A
@clock10address
M=M+D

@8
D=A
@counter10
M=D

@clock10address
D=M

@1
D=A
@screenpixel
M=D

@1
D=A
@pattern101
M=D
@2
D=A
@pattern102
M=D

(CLOCK10)
@screenpixel
D=M
@clock10address
A=M
M=D|M

@pattern101
D=M
@PATTERN101C
D;JLE

@pattern102
D=M
@PATTERN102C
D;JLE

@32
D=A
@clock10address
M=M+D

@pattern101
M=M-1
@pattern102
M=M-1

@CONTINUE102
0;JMP

(PATTERN101C)
@1
D=A
@pattern101
M=D
@CONTINUE102
0;JMP

(PATTERN102C)
@2
D=A
@pattern102
M=D

(CONTINUE102)
@screenpixel
D=M
M=M+D

@counter10
M=M-1
D=M

@CLOCK10
D;JGE

//
// 
// lower half of the clock
//
//

// 4 o'clock
@2
D=-A
@clock4address
M=D+M

// push the line to the bottom
@3429
D=A
@clock4address
M=M+D

@8
D=A
@counter4
M=D

@clock4address
D=M

@1
D=A
@screenpixel
M=D

@1
D=A
@pattern41
M=D
@2
D=A
@pattern42
M=D

(CLOCK4)
@screenpixel
D=M
@clock4address
A=M
M=D|M

@pattern41
D=M
@PATTERN41C
D;JLE

@pattern42
D=M
@PATTERN42C
D;JLE

@32
D=A
@clock4address
M=M+D

@pattern41
M=M-1
@pattern42
M=M-1

@CONTINUE42
0;JMP

(PATTERN41C)
@1
D=A
@pattern41
M=D
@CONTINUE42
0;JMP

(PATTERN42C)
@2
D=A
@pattern42
M=D

(CONTINUE42)
@screenpixel
D=M
M=M+D

@counter4
M=M-1
D=M

@CLOCK4
D;JGE

// 5 o'clock
@2
D=A
@clock5address
M=M+D

@clock5address
D=M

@1
D=A
@screenpixel
M=D

@8
D=A
@counter5
M=D

@4192
D=A
@clock5address
M=M+D


(CLOCK5)
@screenpixel
D=M
@clock5address
A=M
M=D|M

@32
D=A
@clock5address
M=M+D

@screenpixel
D=M
M=M+D

@counter5
M=M-1
D=M

@CLOCK5
D;JGE

// 8 o'clock
@41
D=-A
@clock8address
M=D+M

// push the line to the bottom
@3622
D=A
@clock8address
M=M+D

@8
D=A
@counter8
M=D

@clock8address
D=M

@1
D=A
@screenpixel
M=D

@1
D=A
@pattern81
M=D
@2
D=A
@pattern82
M=D

(CLOCK8)
@screenpixel
D=M
@clock8address
A=M
M=D|M

@pattern81
D=M
@PATTERN81C
D;JLE

@pattern82
D=M
@PATTERN82C
D;JLE

@32
D=-A
@clock8address
M=M+D

@pattern81
M=M-1
@pattern82
M=M-1

@CONTINUE82
0;JMP

(PATTERN81C)
@1
D=A
@pattern81
M=D
@CONTINUE82
0;JMP

(PATTERN82C)
@2
D=A
@pattern82
M=D

(CONTINUE82)
@screenpixel
D=M
M=M+D

@counter8
M=M-1
D=M

@CLOCK8
D;JGE

// 7 o'clock
@2
D=-A
@clock7address
M=D+M

@clock7address
D=M

@1
D=A
@screenpixel
M=D

@8
D=A
@counter7
M=D

@4448
D=A
@clock7address
M=M+D

(CLOCK7)
@screenpixel
D=M
@clock7address
A=M
M=D|M

@32
D=A
@clock7address
M=M-D

@screenpixel
D=M
M=M+D

@counter7
M=M-1
D=M

@CLOCK7
D;JGE

// hands goes here

// big hand
// center of the box: 2560
@2560
D=A
@bighandaddress
M=M+D

@55
D=A
@bighandcounter
M=D

(BIGHAND)
@1
D=A
@bighandaddress
A=M
M=D|M

@32
D=-A
@bighandaddress
M=M+D

@bighandcounter
M=M-1
D=M

@BIGHAND
D;JGT

// small hand
@2560
D=A
@smallhandaddress
M=M+D

@55
D=A
@smallhandcounter
M=D

@smallhandaddress
D=M

@1
D=A
@screenpixel
M=D

@1
D=A
// psh1: Pattern-Small-Hand-1Steps
@psh1
M=D
@2
D=A
// psh2: Pattern-Small-Hand-2Steps
@psh2
M=D

(SMALLHAND)
@screenpixel
D=M
@smallhandaddress
A=M
M=D|M

@psh1
D=M
// C: condition
@PSH1C
D;JLE

@psh2
D=M
@PSH2C
D;JLE

@32
D=A
@smallhandaddress
M=M+D

// shifting
@screenpixel
D=M
@0
A=D
D=D+A
@screenpixel
M=D

@screenpixel
D=M
@RESET
D;JEQ

@psh1
M=M-1
@psh2
M=M-1

@CONTINUESH
0;JMP

(PSH1C)
@1
D=A
@psh1
M=D
@CONTINUESH
0;JMP

(PSH2C)
@2
D=A
@psh2
M=D

(CONTINUESH)
@screenpixel
D=M
M=M+D

@smallhandcounter
M=M-1
D=M

@SMALLHAND
D;JGT

@END
0;JMP

(RESET)
@1
D=A
@screenpixel
M=D

@smallhandaddress
M=M+1

@smallhandcounter
D=M

@SMALLHAND
0;JMP

(END)
@END
0;JMP