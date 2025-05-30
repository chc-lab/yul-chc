% ==============================================================================
%
%          FILE: CIL_MS1.pl
%
%   DESCRIPTION: CIL specialization strategy
%         USAGE: transform input program
%
%  REQUIREMENTS: ---
%       VERSION: 1.0
%       LICENSE: See the file LICENSE.txt for license and copyright details.
%       CREATED: 2015-02-11 00:05:25
%      REVISION: 2015-03-01 16:05:29
% ==============================================================================
:- module(strategy_config,
    [ transf_seq/4
    , unfolding_selection/2
    , folding_selection/2
    , candidate_def/2
    , newdef_from_tbf_def/5
    , canonical_cls/3
    , called_atom_cns/2
    ]).

:- include('rem_int').

:- discontiguous called_atom_cns/2.
:- dynamic called_atom_cns/2.
:- volatile called_atom_cns/2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODE: getCmdType(+CFG, -TYPE,-COMMAND)
% SEMANTICS: (is_callable/is_unfoldable utility predicate)
% get the TYPE and the COMMAND occurring in CFG
getCmdType(cf(cmd(_,Cmd),_),T2) :-
        functor(Cmd,T2,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODE: is_unfoldable(+Uselection,+L)
% TYPE: is_unfoldable(uselection,literal)
% SEMANTICS: Every clause is is_unfoldable wrt literal L selected according to
% the selection rule Uselection

is_unfoldable(Ctx,B) :- is_callable(Ctx,B).

%
is_unfoldable(_Ctx,errorConf(_,_)).
% -- reachable -----------------------------------------------------------------
is_unfoldable(_Ctx,reachable(Cf1,_Cf2)) :-
    Cf1 = cf(cmd(Ep,_),_), 
    inprog:fun(_,_,_,Ep), getCmdType(Cf1,Cmd), Cmd \== ret,
    !,
    fail.
is_unfoldable(_Ctx,reachable(Cf1,_Cf2)) :-
    getCmdType(Cf1,Cmd),
    member(Cmd,[ 
        asgn,
        fun_call,
        mstore,
        sstore,
        %cj,
        ret,
        goto,
        abort,
        revert,
        call
    ]).


% -- t ------------------------------------------------
is_unfoldable(_Ctx,tr(_Cf1,_Cf2,_)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODE: is_callable(+Cselection,+L)
% TYPE: is_callable(term,literal)
% SEMANTICS: L can be called (proved) according to the calling selection rule
% Cselection
% -- tr -------------------------------------------------------------------------
is_callable(_Ctx,tr(Cf1,_Cf2, _)) :-
    getCmdType(Cf1,Cmd),
    member(Cmd,[asgn,mstore,sstore,cj,call,revert,goto]).

is_callable(_Ctx,P) :-
    functor(P,F,_),
    member(F, [ at,
                enabled,
                nextlab, 
                initConf_env1,
                initConf_env2,
                prop,
                update, append, member,
                fun_call_prologue,
                fun_call_epilogue,
                startPP, panicPP,
                call, trace, map_log, copy_term
        ]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODE: called_atom_cns(+Atom,+Cns)
% SEMANTICS: get the Constraints obtained by calling Atom

called_atom_cns(A,C1) :- functor(A,F,N),
        memberchk(F,[
            'tr',
            'eval',
            'fun_call_prologue',
            'fun_call_epilogue',
            'initConf_env1',
            'prop']),
        arg(N,A,C), constr(C,C1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODE: foldable(+Fselection,+L)
% TYPE: foldable(fselection,literal)
% SEMANTICS: L can be folded according to the folding selection rule Fselection.

foldable(smc,L) :- 
        L=(\+ A), !, foldable(smc,A).
% foldable(smc,P) :-
%         functor(P,F,_),
%         member(F,[reachable,incorrect]).
foldable(smc,P) :-
        functor(P,reachable,2).