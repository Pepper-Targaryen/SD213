%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% JL Dessalles - 2014 - www.dessalles.fr                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_line(Phrase) :-
        readString(String), %writef(String),
        str2wlist(String, Phrase).


readString([C|R]) :-
        get0(C), C \== -1, C \== 10, C \== 13, C\==46, !, 
        readString(R).
readString([]).

% Convertit une string en liste de mots
str2wlist(Str, Wordlist) :-
	current_prolog_flag(version_data, swi(6, _,_,_)),
	!,
	str2wlist1([32|Str],[_|Wordlist]).
str2wlist(Str, Wordlist) :-
	split_string(Str, " ", " ", Strlist),
	strings_to_words(Strlist, Wordlist).
	
strings_to_words([], []).
strings_to_words([SW|LSW], [W|LW]) :-
	name(W,SW),
	strings_to_words(LSW, LW).

	
str2wlist1([32,32|Str], Phrase) :-
	!, str2wlist1([32|Str], Phrase).
str2wlist1([32|Str], [[],Mot|Phrase]) :-
	!,
	str2wlist1(Str, [MotStr|Phrase]),
	name(Mot,MotStr).	% translating string into atom when returning from recursion
str2wlist1([44|Str], [[], ','|Phrase]) :-
	% traitment de la virgule
	!,
	str2wlist1(Str, [_|Phrase]).
str2wlist1([C|Str], [[C|MotStr]|Phrase]) :-
	str2wlist1(Str, [MotStr|Phrase]).
str2wlist1([], [[]]).

/*================================
Old version
================================*/

get_line1(Sentence) :-
	read_sentence(Sentence).

read_word([]) :-
	peek_code(C), C = 32, !, get_char(_).	% fin de mot
read_word([]) :-
	peek_code(C), member(C,[-1, 10, 13, 46]), !.	% fin de mot
read_word([C|WordCodes]) :-
	get(C),	% next non-blank caracter
	read_word(WordCodes).

read_sentence([]) :-
	peek_code(C), member(C,[-1, 10, 13, 46]), get_char(_),
	write('fin de ligne'),nl,
	!.	% fin de ligne
read_sentence([Word|Sentence]) :-
	read_word(WordCodes), 
	name(Word, WordCodes),
	read_sentence(Sentence).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% writing trace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic(traceLevel/1).

tl(TrLevel) :- setTraceLevel(TrLevel).	% synonymous

setTraceLevel(TL) :-
	retractall(traceLevel(_)), assert(traceLevel(TL)).

wt(TrLevel,Msg) :-
	% writing for tracing
	traceLevel(TL), TL >= TrLevel,
	% swritef(S," %w ", [Msg]), 
	% writef(S), 
	format(" ~w ", [Msg]), 
	fail.
wt(_,_).

stop(TrLevel) :-
	% interrupt trace by waiting keyboard action
	traceLevel(TL), TL >= TrLevel, !,
	write('(q to stop) > '), get0(C), C \== 113.
stop(_).

