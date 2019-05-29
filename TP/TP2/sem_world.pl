/*---------------------------------------------------------------*/
/* Telecom Paristech - J-L. Dessalles 2019                       */
/* Symbolic Natural Language Processing                          */
/*            http://teaching.dessalles.fr/SNLP                  */
/*---------------------------------------------------------------*/




girl('Ann').
boy('John').
nice('Ann').
room(my_room).
child('John').
child('Pat').
daughter('Ann', 'Lisa').
animate(X):-boy(X).
animate(X):-girl(X).
talk(A, B, _):-
    animate(A),
    animate(B),
    !.
:- consult('Chess.pl').