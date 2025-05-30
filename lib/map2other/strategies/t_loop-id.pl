:- module(t_loop,
    [ transf_seq/4 ]).

% ------------------------------------------------------------------------------
% MODE: transf_seq(+N,+Cl, -FoldedCls,-NewDefs)
% TYPE: transf_seq(nat,list(clause), list(clause),list(clause))
% SEMANTICS: FoldedCls is the result of applying a transformation sequence to
% Cl starting from the intitial program Prog and the definitions DefsIn.
transf_seq(N,_Cls, TransfCls,[]) :-
  map_log(finest,(write('No rule has been applied - Transformation result identity.'), nl, nl)),
  % ----------------------------------------------------------------------------
  map_inprog(TransfCls),
  show_iteration_results(N,
    [(define,[]),(fold,[]),(unfold,[]),(goal_repl,[])]).
