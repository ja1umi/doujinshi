package RandGen is
    subtype Digit_Char is Character range '0'.. '9';
    subtype Digit is Natural range 0..9;
    type Two_State is (Pressed, Released);

    function Random_Digit_Char return Digit_Char;
    function Random_Digit return Digit;
    function Random_2State return Two_State; 
end RandGen;
