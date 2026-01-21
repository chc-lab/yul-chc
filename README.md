# yul-chc

This branch includes the sources of yul-chc: a proof-of-concept implementation of a CHC-based verification framework for Yul programs.

### Requirements
* SWI Prolog: http://www.swi-prolog.org/
* Z3 Theorem Prover: https://github.com/z3prover
* Python

#### Notes

yul-chc has been tested using SWI-Prolog version 9.2.9 and Z3 version 4.13.4 

### USAGE

1. Translating Yul to CHCs

```shell
$ python3 yul2chc
```
The prompt will ask you to enter whath follows:
- the full path to the Yul source file
- the full path of the output file
- the name of the output file (FILENAME)

and produces as output a file named FILENAME.pl

2. Generating VCs

```shell
$ ./scripts/transform FILENAME.pl lib/yul/configs/vcg_multistep.iteration
```

3. Translating CHCs to SMT-LIBv2 

```shell
$ ./scripts/transform --map2smt FILENAME.t.pl
```

4. Checking satisfiability of CHCs

```shell
$ z3 FILENAME.t.smt2
```

## Acknowledgments

This project is partially supported by the PNRR project FAIR –- Future AI Research (PE00000013), Spoke 9 -- Green-aware AI, under the NRRP MUR program funded by the NextGenerationEU.
