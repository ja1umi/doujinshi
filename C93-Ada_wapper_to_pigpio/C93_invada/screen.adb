with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
package body Screen is
	procedure cls is
	begin
		Put(ASCII.ESC);
		Put("[2J");
	end;

	procedure locate(x, y : Natural) is
	begin
		Put(ASCII.ESC);
--		Put("[H");
--		Put("[C");
--		Put(Character'Val(x));
--		Put("[B");
--		Put_Line(Character'Val(y));
		Put("[" & Trim(Integer'Image(y), Left) & ";" & Trim(Integer'Image(x), Left) & "H");
	end;
end Screen;

