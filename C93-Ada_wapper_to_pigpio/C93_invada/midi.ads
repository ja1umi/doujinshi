with pigpio_ada; use pigpio_ada;
package MIDI is
--	subtype UByte is Natural range 0 .. 255;
    type Variadic_Array is array(Positive range <>) of UByte;
    type Module_Selection is (GS, XG, GM);

    procedure MIDI_Open (serial_tty : in String);
--    procedure Send (data : in Ubyte);
    procedure MIDI_Send (data : in Ubyte);
    procedure MIDI_Send (stat, data1, data2 : in UByte);
    procedure MIDI_Send (data1, data2 : in UByte);
    procedure MIDI_Send (va : in Variadic_Array);
    procedure MIDI_Init_Sound_Module (selection : Module_Selection := GS);
    procedure MIDI_Display_Message (str : in String);
    procedure MIDI_Close;
end MIDI;

    