:- dynamic history/2.

% возможные ходы коня
move(1, 2).
move(-1, 2).
move(1, -2).
move(-1, -2).
move(2, 1).
move(-2, 1).
move(2, -1).
move(-2, -1).

% проверка на границы доски
border_check(X, Y) :-
	X >= 1, Y >= 1,
	X =< 8, Y =< 8.

% сохранение истории ходов без повторений
remember_move([X, Y]) :-
	\+ history(X, Y),
	assert(history(X, Y)).

% выполнение 3-х ходов
three_moves(Position, Position3):-
	making_move(Position, Position1),
	making_move(Position1, Position2),
	making_move(Position2, Position3),
	remember_move(Position3).

% выполнение хода
making_move([X, Y], [X_next, Y_next]) :-
	border_check(X, Y),
	move(X0, Y0),
	X_next is X + X0,
	Y_next is Y + Y0,
	border_check(X_next, Y_next).

% генератор
generator([X, Y], Position) :-
	border_check(X, Y),
	remember_move([X, Y]),
	three_moves([X, Y], Position).
