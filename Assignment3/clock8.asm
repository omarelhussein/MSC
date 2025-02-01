@SCREEN
D=A
@address
M=D

//create space for border of clock
@address
D=M
@12
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

@20 //10 to the right means 10*16 = 160 pixels down pixels
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
@address
A=M
M=1

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
@8
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
@1280
D=A
@clock12address
M=M+D

// length of the 12 o'clock line
@16
D=A
@counter12
M=D

(CLOCK12)
@clock12address
A=M
M=1

@32
D=A

@clock12address
M=M+D

@counter12
M=M-1
D=M

@CLOCK12
D;JGE

// 11 o'clock
@clock12address
D=M
@clock11address
M=D
@2
D=-A
@clock11address
M=D+M

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

@256
D=-A
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
@clock12address
D=M
@clock1address
M=D
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

@counter1Tmp
M=D

@256
D=-A
@clock1address
M=M+D

(PUSHCLOCK1DOWN)
@clock1address
D=M
@32
D=A
@clock1address
M=M+D

@counter1Tmp
M=M-1
D=M

@PUSHCLOCK1DOWN
D;JGE

(CLOCK1)
@screenpixel
D=M
@clock1address
A=M
M=D|M

@32
D=-A
@clock1address
M=M+D

@screenpixel
D=M
M=M+D

@counter1
M=M-1
D=M

@CLOCK1
D;JGE

//2 o'clock
@clock12address
D=M
@clock2address
M=D
@3 // 5*16 to the right
D=A
@clock2address
M=D+M

// push the line to the bottom
@864
D=A
@clock2address
M=M+D

@4
D=A
@counter2
M=D

@clock2address
D=M

@1
D=A
@screenpixel
M=D
 
(CLOCK2)
@screenpixel
D=M
@clock2address
A=M
M=D|M

@32
D=-A
@clock2address
M=M+D

@screenpixel
D=M
M=M+D

@counter2
M=M-1
D=M

@CLOCK2
D;JGE 

// 10 o'clock
@clock12address
D=M
@clock10address
M=D
@3
D=-A
@clock10address
M=D+M

@clock10address
D=M

// push the line to the bottom
@608
D=A
@clock10address
M=M+D

@1
D=A
@screenpixel
M=D

@4
D=A
@counter10
M=D

(CLOCK10)
@screenpixel
D=M
@clock10address
A=M
M=D|M

@32
D=A
@clock10address
M=M+D

@screenpixel
D=M
M=M+D

@counter10
M=M-1
D=M

@CLOCK10
D;JGE

// 3 o'clock
@clock12address
D=M
@clock3address
M=D
@4
D=A
@clock3address
M=D+M

// push the line to the bottom
@1600
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

(END)

@END
0;JMP
