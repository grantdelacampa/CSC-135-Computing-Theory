%Grant De La Campa
%CSc 135 
%Assignment 3

%***************************************************
%-------------------Problem 1-----------------------
%***************************************************
factorial(0,O) :-
    O is 1.
factorial(N,O) :-
    N>0,
    N1 = N-1,
    factorial(N1, O1),
    O is O1 * N.

%***************************************************
%-------------------Problem 2-----------------------
%***************************************************

listpicket(K,[],L):-append([K],[],L).
listpicket(K,[H|T],L):-
    append([K],[H],L1),
    listpicket(K,T,L2),
    append(L1, L2, L).

%***************************************************
%-------------------Problem 3-----------------------
%***************************************************

listpicketall(K,[],L):-
	append([K],[],L).
listpicketall(K,A,L):-
	A=[H|T],
	( is_list(H)->listpicketall(K,H,L1),
	append([K],[L1],L2),
	listpicketall(K,T,L3),
	append(L2,L3,L);
		append([K],[H],L1),
	listpicketall(K,T,L2),
	append(L1,L2,L)).

%***************************************************
%-------------------Problem 4-----------------------
%***************************************************

:-use_module(libraary(clpr)).

crytpo(C,K,L,M)  :- {C + K - L - M = 4},  crytpo1(C,K,L,M).
crytpo1(C,K,L,M) :- {C + K + L + M = 14}, crytpo2(C,K,L,M).
crytpo2(C,K,L,M) :- {C - K + L - M = 2},  crytpo3(C,K,L,M).
crytpo3(C,K,L,M) :- {C - K - L + M = 12}.	

%***************************************************
%-------------------Problem 5-----------------------
%***************************************************

%Trace of Reverse: 
 %Call:reverse([3, 5, 6, 2], _11726) 
 %Call:rev([3, 5, 6, 2], [], _11726) 
 %Call:rev([5, 6, 2], [3], _11726) 
 %Call:rev([6, 2], [5, 3], _11726) 
 %Call:rev([2], [6, 5, 3], _11726) 
 %Call:rev([], [2, 6, 5, 3], _11726) 
 %Exit:rev([], [2, 6, 5, 3], [2, 6, 5, 3]) 
 %Exit:rev([2], [6, 5, 3], [2, 6, 5, 3]) 
 %Exit:rev([6, 2], [5, 3], [2, 6, 5, 3]) 
 %Exit:rev([5, 6, 2], [3], [2, 6, 5, 3]) 
 %Exit:rev([3, 5, 6, 2], [], [2, 6, 5, 3]) 
 %Exit:reverse([3, 5, 6, 2], [2, 6, 5, 3]) 
 
%Trace of Reverse2: 
 %Call:reverse2([3, 5, 6, 2], _12516) 
 %Call:reverse2([5, 6, 2], _12712) 
 %Call:reverse2([6, 2], _12712) 
 %Call:reverse2([2], _12712) 
 %Call:reverse2([], _12712) 
 %Exit:reverse2([], []) 
 %Call:lists:append([], [2], _12720) 
 %Exit:lists:append([], [2], [2]) 
 %Exit:reverse2([2], [2]) 
 %Call:lists:append([2], [6], _12726) 
 %Exit:lists:append([2], [6], [2, 6]) 
 %Exit:reverse2([6, 2], [2, 6]) 
 %Call:lists:append([2, 6], [5], _12738) 
 %Exit:lists:append([2, 6], [5], [2, 6, 5]) 
 %Exit:reverse2([5, 6, 2], [2, 6, 5]) 
 %Call:lists:append([2, 6, 5], [3], _12516) 
 %Exit:lists:append([2, 6, 5], [3], [2, 6, 5, 3]) 
 %Exit:reverse2([3, 5, 6, 2], [2, 6, 5, 3]) 
 
%Reverse2 is more expensive because it incorporates extra calls for append which results in a significantly longer runtime than the previously listed reverse. 
