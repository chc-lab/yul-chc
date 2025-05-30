% (c) Florence Benoy, Andy King and Fred Mesnard
%
% See the TPLP paper "Calculating Convex Hulls with
% a Linear Solver" for explanation and discussion
%

% REVIEW: commented out project/3
:- module(hull, [convex_hull/6]).
%:- module(hull, [project/3, convex_hull/6]).

%project(Xs, Cxs, ProjectCxs) :-
%    call_residue(copy_term(Xs-Cxs, CpyXs-CpyCxs), _),
%    tell_cs(CpyCxs),
%    prepare_dump(CpyXs, Xs, Zs, DumpCxs, ProjectCxs),
%    dump(Zs, Vs, DumpCxs), Xs = Vs.

:- assert(system_type(swi)).   % REVIEW

% REVIEW: project: to be reviewed
project(Xs, Cxs, ProjectCxs) :-
    (system_type(swi) ->
        copy_term(Xs-Cxs, CpyXs-CpyCxs,_)                 %SWI
    ;
        call_residue(copy_term(Xs-Cxs, CpyXs-CpyCxs), _)  %SICS
    ),
    tell_cs(CpyCxs),
    prepare_dump(CpyXs, Xs, Zs, DumpCxs, ProjectCxs),
    (system_type(swi) ->
         reverse(Zs,Zs1)                                  %SWI
    ;
         Zs=Zs1                                           %SICS
    ),
    dump(Zs1, Vs1, DumpCxs),
    (system_type(swi) ->
         reverse(Vs1,Vs)                                  %SWI
    ;
         Vs1=Vs                                           %SICS
    ),
    Xs = Vs.

tell_cs([]).
tell_cs([C|Cs]) :-  {C}, tell_cs(Cs).

prepare_dump([], [], [], Cs, Cs).
prepare_dump([X|Xs], YsIn, ZsOut, CsIn, CsOut) :-
    (ground(X) ->
        YsIn  = [Y|Ys],
        ZsOut = [_|Zs],
        CsOut = [Y=X|Cs]
    ;
        YsIn  = [_|Ys],
        ZsOut = [X|Zs],
        CsOut = Cs
    ),
    prepare_dump(Xs, Ys, Zs, CsIn, Cs).

convex_hull(Xs, Cxs, Ys, Cys, Zs, Czs) :-
    scale(Cxs, Sig1, [], C1s),
    scale(Cys, Sig2, C1s, C2s),
    add_vect(Xs, Ys, Zs, C2s, C3s),
    project(Zs, [Sig1 >= 0, Sig2 >= 0, Sig1+Sig2 = 1|C3s], Czs).

scale([], _, Cs, Cs).
scale([C1|C1s], Sig, C2s, C3s) :-
    C1 =.. [RelOp, A1, B1],
    C2 =.. [RelOp, A2, B2],
    mul_exp(A1, Sig, A2),
    mul_exp(B1, Sig, B2),
    scale(C1s, Sig, [C2|C2s], C3s).

mul_exp(E1, Sigma, E2) :- once(mulexp(E1, Sigma, E2)).

mulexp(  X,   _,     X) :- var(X).
mulexp(N*X,   _,   N*X) :- ground(N), var(X).
mulexp( -X, Sig,    -Y) :- mulexp(X, Sig, Y).
mulexp(A+B, Sig,   C+D) :- mulexp(A, Sig, C), mulexp(B, Sig, D).
mulexp(A-B, Sig,   C-D) :- mulexp(A, Sig, C), mulexp(B, Sig, D).
mulexp(  N, Sig, N*Sig) :- ground(N).

add_vect([], [], [], Cs, Cs).
add_vect([U|Us], [V|Vs], [W|Ws], C1s, C2s) :-
    add_vect(Us, Vs, Ws, [W = U+V|C1s], C2s).
