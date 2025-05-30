
% MODE: transf_seq(+N,+Cl,+DefsIn, -FoldedCls,-DefsOut,-NewDefs)
% TYPE: transf_seq(nat,clause,list(def),defs_symtab, list(clause),defs_symtab,defs_symtab)
% SEMANTICS: FoldedCls is the result of applying a transformation sequence to Cl.
transf_seq(N,[Cl|Cls], FoldedCls,ClsToBeProc) :-
  % Unfolding ------------------------------------------------------------------
  map_log(finest,
    ( dashedline, write('[UDF Step 1 - Unfolding]'           ), nl, nl)),
  unfold([Cl],UnfoldedCls),
  % Clause removal -------------------------------------------------------------
  %map_log(finest,(dashedline,write('[UDF Step 2 - Remove Useless Clauses]'), nl, nl)),
  %remove_unsat_subsumed(UnfoldedCls,SCls),
  UnfoldedCls = SCls,
  % Goal Replacement -----------------------------------------------------------
  map_log(finest,
    ( dashedline, write('[UDF Step 2 - Goal Replacement]'    ), nl, nl ) ),
  goal_replacement(SCls,GCls),
  % Definition and Folding -----------------------------------------------------
  map_log(finest,
    ( dashedline, write('[UDF Step 3 - Definition & Folding]'), nl, nl ) ),
  define_fold(GCls,[], FoldedCls,NewDefs),
  append(NewDefs,Cls,ClsToBeProc),
  % ----------------------------------------------------------------------------
  show_iteration_results(N,
    [(unfold,SCls),(goal_repl,GCls),(define,NewDefs),(fold,FoldedCls)]).
