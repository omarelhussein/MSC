@SCREEN
D=A
@address
M=D

//create space for border of clock
@12
D=A
@address
M=M+D

@1024
D=A
@address
M=M+D

@address
D=M
@startaddress
M=D

// draw first top line
@8
D=A
@linecounter
M=D

(TOP_LINE)
@address
A=M
M=-1
@address
M=M+1
@linecounter
M=M-1
D=M
@TOP_LINE
D;JGE

// draw right line
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

// draw left line using start address
@160
D=A
@linecounter
M=D

(LEFT_LINE)
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

// Bottom line
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

// 12 o'clock
@SCREEN
D=A
@clock12address
M=D
@16
D=A
@clock12address
M=M+D
@1280
D=A
@clock12address
M=M+D

@12
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
@1
D=-A
@clock11address
M=D+M

@2          // Changed initial pixel value
D=A
@screenpixel
M=D
@pixeltemp
M=D

@4
D=A
@counter11
M=D

@96         // Adjusted vertical offset
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

// Modified pixel value progression
@screenpixel
D=M
@3          // Add 3 each time for proper angle
D=D+A
@screenpixel
M=D

@counter11
M=M-1
D=M
@CLOCK11
D;JGE

// 1 o'clock
@clock12address
D=M
@clock1address
M=D
@1
D=A
@clock1address
M=D+M

@2          // Same initial pixel value as 11
D=A
@screenpixel
M=D
@pixeltemp
M=D

@4
D=A
@counter1
M=D

@96         // Same vertical offset as 11
D=-A
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
M=M+D

// Modified pixel value progression
@screenpixel
D=M
@3          // Add 3 each time for proper angle
D=D+A
@screenpixel
M=D

@counter1
M=M-1
D=M
@CLOCK1
D;JGE

// 10 o'clock
@clock12address
D=M
@clock10address
M=D
@2
D=-A
@clock10address
M=D+M

@1
D=A
@screenpixel
M=D
@pixeltemp
M=D

@4
D=A
@counter10
M=D

@256
D=-A
@clock10address
M=M+D

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

// Double the pixel value
@screenpixel
D=M
@pixeltemp
M=D
@screenpixel
D=M
@pixeltemp
D=M
@screenpixel
M=D+M

@counter10
M=M-1
D=M
@CLOCK10
D;JGE

// 2 o'clock
@clock12address
D=M
@clock2address
M=D
@2
D=A
@clock2address
M=D+M

@1
D=A
@screenpixel
M=D
@pixeltemp
M=D

@4
D=A
@counter2
M=D

@256
D=-A
@clock2address
M=M+D

(CLOCK2)
@screenpixel
D=M
@clock2address
A=M
M=D|M
@32
D=A
@clock2address
M=M+D

// Double the pixel value
@screenpixel
D=M
@pixeltemp
M=D
@screenpixel
D=M
@pixeltemp
D=M
@screenpixel
M=D+M

@counter2
M=M-1
D=M
@CLOCK2
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

@512
D=-A
@clock3address
M=M+D

@8
D=A
@counter3
M=D

(CLOCK3)
@clock3address
A=M
M=1
@32
D=A
@clock3address
M=M+D
@counter3
M=M-1
D=M
@CLOCK3
D;JGE

// 9 o'clock
@clock12address
D=M
@clock9address
M=D
@4
D=-A
@clock9address
M=D+M

@512
D=-A
@clock9address
M=M+D

@8
D=A
@counter9
M=D

(CLOCK9)
@clock9address
A=M
M=1
@32
D=A
@clock9address
M=M+D
@counter9
M=M-1
D=M
@CLOCK9
D;JGE

// 6 o'clock
@clock12address
D=M
@clock6address
M=D

@1024
D=-A
@clock6address
M=M+D

@12
D=A
@counter6
M=D

(CLOCK6)
@clock6address
A=M
M=1
@32
D=A
@clock6address
M=M+D
@counter6
M=M-1
D=M
@CLOCK6
D;JGE

(END)
@END
0;JMP