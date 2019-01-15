with Interfaces.C.Strings; use Interfaces.C.Strings;
package body Pigpio_Ada is
Pi_Library_Call_Failed : exception;

	-- IN GNAT, the standard predefined Ada types correspond to the Standard C
	-- types

	-- Essential
	-- ...
	procedure PiGpioInitialise is
		function GpioInitialise return Integer;
			pragma Import(C, GpioInitialise, External_Name => "gpioInitialise");
		Result : Integer := GpioInitialise;
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiGpioInitialise;

	-- ...

	procedure PiGpioTerminate is
		procedure GpioTerminate;
			pragma Import(C, gpioTerminate, External_Name => "gpioTerminate");
	begin
		GpioTerminate;
	end PiGpioTerminate;


	-- Beginner
	-- ...
	procedure PiGpioSetMode (gpio : in GPIO_Range; mode : in GPIO_Mode) is
		function GpioSetMode (g, m : Integer) return Integer;
			pragma Import(C, GpioSetMode, External_Name => "gpioSetMode");
		Result : Integer := GpioSetMode(gpio, mode);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiGpioSetMode;

	-- ...

	function PiGpioGetMode (gpio : GPIO_Range) return GPIO_Mode is
		function GpioGetMode (g : Integer) return Integer;
			pragma Import(C, GpioGetMode, External_Name => "gpioGetMode");
		Result : Integer := GpioGetMode(gpio);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
		return GPIO_Mode(Result);
	end PiGpioGetMode;

	-- ...

	procedure PiGpioSetPullUpDown (gpio : in GPIO_Range; pud : in GPIO_PUD) is
		function GpioSetPullUpDown (g, pud : Integer) return Integer;
			pragma Import(C, GpioSetPullUpDown, External_Name => "gpioSetPullUpDown");
		Result : Integer := GpioSetPullUpDown(gpio, pud);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiGpioSetPullUpDown;

	-- ...

	function PiGpioRead (gpio : GPIO_Range) return GPIO_Level is
		function GpioRead (g : Integer) return Integer;
			pragma Import(C, GpioRead, External_Name => "gpioRead");
		Result : Integer := GpioRead(gpio);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
		return GPIO_Level(Result);
	end PiGpioRead;

	-- ...

	procedure PiGpioWrite (gpio : in GPIO_Range; level : in GPIO_Level ) is
		function GpioWrite(g, lv : Integer) return Integer;
			pragma Import (C, GpioWrite, External_Name => "gpioWrite");
		Result : Integer := GpioWrite(gpio, level);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiGpioWrite;

	-- ...

    procedure PiGpioSetTimerFunc (time, millis : in Natural; callback : access procedure) is
        function GpioSetTimerFunc (tm, ms : Integer; cb : access procedure) return Integer;
	        pragma Import(C, GpioSetTimerFunc, External_Name => "gpioSetTimerFunc");
        Result : Integer := GpioSetTimerFunc (time, millis, callback);
    begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Integer(Result)) & " )";
		end if;
    end PiGpioSetTimerFunc;

	-- Serial
	-- ...
	function PiSerOpen(sertty : String; baud : SpeedSelection; serFlags : Natural := 0) return Handle is	
	-- The baud rate must be one of 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400,
	-- 4800, 9600, 19200, 38400, 57600, 115200 or 230400.

		function SerOpen(stty : chars_ptr; bd, flgs : Integer) return Integer;
			pragma Import (C, SerOpen, External_Name => "serOpen");
		CChars : chars_ptr := New_String(sertty);
		Ser_Handle : Integer := SerOpen(CChars, Speed(baud), serFlags);
	begin
		Free(CChars);
		if Ser_Handle < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Ser_Handle) & " )";
		end if;
		return Handle(Ser_Handle);		
	end PiSerOpen;

	-- ...

	procedure PiSerClose(hdl : in Handle) is
		function SerClose (h : Integer) return Integer;
			pragma Import (C, SerClose, External_Name => "serClose");
		Result : Integer := SerClose(hdl);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiSerClose;

	-- ...

	procedure PiSerWriteByte(hdl: in Handle; value: in UByte) is
		function SerWriteByte(h, v : Integer) return Integer;
			pragma Import (C, SerWriteByte, External_Name => "serWriteByte");
		Result : Integer := SerWriteByte(hdl, value);
	begin
		if Result < 0 then
			raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiSerWriteByte; 

	-- ...

	function PiSerReadByte(hdl : Handle) return UByte is
		function SerReadByte(h : Integer) return Integer;
			pragma Import (C, SerReadByte, External_Name => "serReadByte");
		Result : Integer := SerReadByte(hdl);
	begin
		if Result < 0 then
			raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
		return UByte(Result);
	end PiSerReadByte;


	-- Utilities
	-- ...
	function PiGpioVersion return Positive is
		function GpioVersion return Integer;
			pragma Import(C, GpioVersion, external_Name => "gpioVersion");
		Result : Integer := GpioVersion;
	begin
		return Positive(GpioVersion);
	end PiGpioVersion;

	-- ...

	procedure PiGpioSleep (timetype : in Time_Type; seconds : in Natural; micros : in Natural) is
		function GpioSleep(typ, s, mis : Integer) return Integer;
			pragma Import(C, GpioSleep, External_name => "gpioSleep");
		Result : Integer := GpioSleep(timetype, seconds, micros);
	begin
		if Result < 0 then
    		raise Pi_Library_Call_Failed with "Library call failed for pigpio (" & Integer'Image(Result) & " )";
		end if;
	end PiGpioSleep;

end Pigpio_Ada;

