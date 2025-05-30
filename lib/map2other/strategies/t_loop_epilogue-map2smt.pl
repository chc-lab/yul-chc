:- module(t_loop_epilogue, [ transf_seq_epilogue/2 ]).

% MODE: transf_seq_epilogue(+Cls, -Cls)
% TYPE: transf_seq_epilogue(list(clause), list(clause))
% SEMANTICS:
transf_seq_epilogue(Cls, Cls) :-
  % write program to file
  vs(input_filename(InFileName)),
  ( atom_concat(BaseName,'.pl',InFileName) -> true ; InFileName=BaseName ), 
  atom_concat(BaseName,'.smt2',OutSmt),
  tell(OutSmt),
  map2(smt,Cls),
  told.
