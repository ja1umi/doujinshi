with pigpio_ada; use pigpio_ada;
package body MIDI is

    PI_NO_HANDLE : constant Integer := -24; -- no handle available

    Ser_Handle : Handle;

    procedure MIDI_Open (serial_tty : in String) is
    begin
        Ser_Handle := PiSerOpen (sertty => serial_tty, baud => B38400);
    end MIDI_Open;

    procedure MIDI_Close is
    begin
        PiSerClose(hdl => Ser_Handle);
    end MIDI_Close;

    procedure Send (hdl : in Handle; data : in Ubyte) is
    begin
        PiSerWriteByte (hdl => Ser_Handle, value => data);
    end Send;

    procedure MIDI_Send (data : in Ubyte) is
    begin
        Send (hdl => Ser_Handle, data => data); 
    end MIDI_Send;

    procedure MIDI_Send (stat, data1, data2 : in UByte) is
    begin
        Send (hdl => Ser_Handle, data => stat);
        Send (hdl => Ser_Handle, data => data1);
        Send (hdl => Ser_Handle, data => data2);
    end MIDI_Send;
    
    procedure MIDI_Send (data1, data2 : in UByte) is
    begin
        Send (hdl => Ser_Handle, data => data1);
        Send (hdl => Ser_Handle, data => data2);
    end MIDI_Send;

    procedure MIDI_Send (va : in Variadic_Array) is
    begin
        for i in va'Range loop
            Send (hdl => Ser_Handle, data => va(i));
        end loop;
    end MIDI_Send;

    procedure MIDI_Init_Sound_Module (selection : Module_Selection := GS) is
        gs_reset : Variadic_Array(1 .. 11) := (16#F0#, 16#41#, 
            16#10#, 16#42#, 16#12#, 16#40#, 0, 16#7F#, 0 ,
            16#41#, 16#F7#);
    begin
		-- vsendMIDImsg(0xF0, 0x41, 0x10, 0x42, 0x12, 0x40, 0, 0x7F, 0 ,0x41, 0xF7);	// GS reset
		-- delay(100);
		-- sendMIDImsg(0xB0, 0, 8);		// "Sine-wave" @ SC-55mk2
		-- sendMIDImsg(0xB0, 0x20, 0);
		-- sendMIDImsg2(0xC0, 80);
		-- sendMIDImsg(0xB0, 0, 0);		// "flute" @ SC-55mk2
		-- sendMIDImsg(0xB0, 0x20, 0);
		-- sendMIDImsg2(0xC0, 73);
        case selection is
            when GS =>
                MIDI_Send (gs_reset);    -- GS reset
            when XG =>
                null;   -- Stub. To be implemented
            when GM =>
                null;   -- Stub. To be implemented
            when others =>
                null;
        end case;
        delay 0.1;
    end MIDI_Init_Sound_Module;

    procedure MIDI_Display_Message (str : in String) is
        dat : Natural;
        csum, b : UByte;
        b1 : UByte := 16#10#;
        b2, b3 : UByte := 0;
        msg : Variadic_Array(1 .. 8) := (16#F0#, 16#41#, 16#10#, 
            16#45#, 16#12#, b1, b2, b3);
    begin
		-- int csum, b, dat, b1 = 0x10, b2 = 0, b3 = 0;
		-- String str;
		--
		-- str = msg.concat("                                ").substring(0, 32);
		-- vsendMIDImsg(0xF0, 0x41, 0x10, 0x45, 0x12, b1, b2, b3);
		-- dat = 0;
		-- for (int i = 0; i <32; i++) {
		-- 	b = str.charAt(i);
		-- 	serOut(b);
		--  dat += b;  
		--}
		-- csum = 128 - ((b1 + b2 + b3 + dat) & 0x7F);
		-- sendMIDImsg2(csum, 0xF7);
		-- delay(50);
        MIDI_Send (msg);
        dat := 0;
        for i in str'Range loop
            b := Character'Pos(str(i)); Send (hdl => Ser_Handle, data => b);
            dat :=  dat + b;
        end loop;
        csum := 128 -  ((b1 + b2 + b3 + dat) mod 128);
        MIDI_Send (csum, 16#F7#);
        delay 0.05; 
    end MIDI_Display_Message;
    
begin
    Ser_Handle := PI_NO_HANDLE; -- note: PiSerOpen retunrs 0 if Okay.
end MIDI;

