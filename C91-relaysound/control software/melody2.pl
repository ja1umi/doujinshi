test(
% MIDI note# 24, 26, 28, 29, 31, 33, 35 and 26
     [[63, 16],
     [56, 16],
     [48, 16],
     [44, 16],
     [37, 16],
     [30, 16],
     [24, 16],
     [21, 16]]
    ).

starship(
	[
	[21,8],
	[21,8],
	[24,8],
	[21,8],
	[15,8],
	[10,8],
	[21,8],
	[37,16],
	[30,8],
	[37,16],

	[21,8],
	[21,8],
	[24,8],
	[21,8],
	[15,8],
	[10,8],
	[8,8],
	[10,16],
	[15,16],

	[21,8],
	[8,8],
	[10,8],
	[15,8],
	[15,8],
	[21,8],
	[15,8],
	[37,16],
	[21,8],
	[15,8],
	[10,8],
	[21,8],

	[37,8],
	[44,16],
	[21,16],
	[21,8],
	[21,8],
	[24,16],
	[21,8],
	[24,16],


	[21,8],
	[21,8],
	[24,8],
	[21,8],
	[15,8],
	[10,8],
	[21,8],
	[37,16],
	[30,8],
	[37,16],

	[21,8],
	[21,8],
	[24,8],
	[21,8],
	[15,8],
	[10,8],
	[8,8],
	[10,16],
	[15,16],

	[21,8],
	[8,8],
	[10,8],
	[15,8],
	[15,8],
	[10,8],
	[8,16],
	[4,8],
	[21,8],
	[15,8],
	[10,8],
	[21,8],

	[30,8],
	[44,16],
	[21,16],
	[24,8],
	[30,8],
	[24,8],
	[21,16]
	]
).
	
play_bars([]).
play_bars([X | Xs]):-
	nth1(1, X, Notenum), nth1(2, X, Notelen),
%	writef('Note# = %w, Length = %w\n', [Notenum, Notelen]),
	note_on(Notenum, Notelen), play_bars(Xs), note_off(Notenum, 1).

note_on(Notenum, Notelen):-
%	python_call_with_numeric_args('GPIO', 'noteonsim', [Notenum, Notelen], _).
	python_call_with_numeric_args('GPIO', 'noteon', [Notenum, Notelen], _).

note_off(Notenum, Notelen):-
%	python_call_with_numeric_args('GPIO', 'noteonsim', [Notenum, Notelen], _).
	python_call_with_numeric_args('GPIO', 'noteoff', [Notenum, Notelen], _).

initialize:-
	python_call('GPIO', 'init', _).
