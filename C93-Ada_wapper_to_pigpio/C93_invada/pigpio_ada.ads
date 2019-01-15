package Pigpio_Ada is

	PI_INPUT    : constant Natural := 0;
	PI_OUTPUT   : constant Natural := 1;
	PI_PUD_OFF  : constant Natural := 0;
	PI_PUD_DOWN : constant Natural := 1;
	PI_PUD_UP   : constant Natural := 2;

	type SpeedSelection is (B50, B75, B110, B134, B150, B200, 
		B300, B600, B1200, B1800, B2400, B4800, B9600, B19200,
		B38400, B57600, B115200, B230400
	);
	Speed : constant array(SpeedSelection) of Natural :=
		(B50 => 50,
	 	 B75 => 75,
	 	 B110 => 110,
	 	 B134 => 134,
	 	 B150 => 150,
	 	 B200 => 200,
	 	 B300 => 300,
	 	 B600 => 600,
	 	 B1200 => 1200,
	 	 B1800 => 1800,
	 	 B2400 => 2400,
	 	 B4800 => 4800,
	 	 B9600 => 9600,
	 	 B19200 => 19200,
	 	 B38400 => 38400,
	 	 B57600 => 57600,
	 	 B115200 => 115200,
	 	 B230400 => 230400
	);

	subtype Time_Type is Natural range 0 .. 1;
	subtype GPIO_Range is Natural range 0 .. 53;
	subtype GPIO_Mode is Natural range 0 .. 7;
	subtype GPIO_Level is Natural range 0 .. 1;
	subtype GPIO_PUD is Natural range 0 .. 2;
	subtype Handle is Integer;
	subtype UByte is Natural range 0 .. 255;

	-- Essential
	procedure PiGpioInitialise;
	procedure PiGpioTerminate;

	-- Beginner
	procedure PiGpioSetMode (gpio : in GPIO_Range; mode : in GPIO_Mode);
	function PiGpioGetMode (gpio : GPIO_Range) return GPIO_Mode;
	procedure PiGpioSetPullUpDown (gpio : in GPIO_Range; pud : in GPIO_PUD);
	function PiGpioRead (gpio : GPIO_Range) return GPIO_Level;
	procedure PiGpioWrite (gpio : in GPIO_Range; level : in GPIO_Level);
	procedure PiGpioSetTimerFunc (time, millis : in Natural; callback : access procedure);

	-- Serial
	function PiSerOpen(sertty : in String; baud : in SpeedSelection; serFlags : in Natural := 0) return Handle;
	procedure PiSerClose(hdl : in Handle);	
	procedure PiSerWriteByte(hdl: in Handle; value: in UByte);
	function PiSerReadByte(hdl : Handle) return UByte;

	-- Utilities
	function PiGpioVersion return Positive;
	procedure PiGpioSleep (timetype : in Time_Type; seconds : in Natural; micros : in Natural);

end Pigpio_Ada;

