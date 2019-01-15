with Ada.Numerics.Discrete_Random;
package body RandGen is

    package Random_DigitChar is new Ada.Numerics.Discrete_Random (Digit_Char);
    use Random_DigitChar;

    package Random_DigitNumber is new Ada.Numerics.Discrete_Random (Digit);
    use Random_DigitNumber;

    package Random_Two_State is new Ada.Numerics.Discrete_Random (Two_State);
    use Random_Two_State;
    
    gen : Random_DigitChar.Generator;
    gend : Random_DigitNumber.Generator;
    gen2 : Random_Two_State.Generator;

    function Random_Digit_Char return Digit_Char is
    begin
        return Random_DigitChar.Random (gen);
    end Random_digit_char;

    function Random_Digit return Digit is
    begin
        return Random_DigitNumber.Random (gend);
    end Random_digit;

    function Random_2State return Two_State is
    begin
        return Random_Two_State.Random (gen2);
    end Random_2State;

begin
    Reset (gen); Reset (gend); Reset (gen2);
end RandGen;
