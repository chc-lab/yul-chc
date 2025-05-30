:- module(t_loop_prologue,
    [ canonical_cls/3 ]).

:- use_module(transformer(types)).
:- use_module(library(clpb)).
:- use_module(library(lists)).

:- assert(user:get_transformer_option(inprog_invokable,_N1/_A1:false)),
   assert(user:get_transformer_option(inprog_canonical_conversion,_N2/_A2:true)).

% MODE: transf_seq_prologue(+Cls, -Cls)
% TYPE: transf_seq_prologue(list(clause), list(clause))


% ------------------------------------------------------------------------------
canonical_cls(Head,Body, [Cl]) :-
  constr_tt(Constr),
  clause_components(Cl, Head,Constr,Body).
