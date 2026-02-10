# yul-chc

This branch contains changes to the interpreter and translation modules that enable multiple contracts to run simultaneously. 
These changes affect the executable version of the interpreter rather than the version used for specialisation (https://github.com/chc-lab/yul-chc).

### Requirements
* SWI Prolog: http://www.swi-prolog.org/
* Python

### USAGE

1. Translating Yul to CHCs

```shell
$ python3 yul2chc
```
The prompt will ask you to enter whath follows:
- the full path to the original source file
- the full path to the Yul source file
- the full path of the output file
- the contract name

and produces as output a file named CONTRACTNAME.pl


### Translation module

The module has been updated to detect whether a Yul file provided as input contains one or more contracts. A unique address is generated for each contract.
For example, if a Yul file contains two contracts, C1 and C2, the translation module will produce:

                                                                          address([(0x5dc80c7b...,'c1'),(0x4078c813...,'c2')]).

Since functions with the same name may exist (e.g. an identity function or other common utility functions), an additional field has been added to the encoded information: a combination of the contract name and its associated addres.
The translation module will produce:

                                                                      fun('c1_0x5dc80c7b...', obj_constructor_C1_49, [], [], 'obj_constructor_C1_49_ret').

Information on the externally callable contract functions, together with the corresponding signatures, is also included. 


### Interpreter

The way in which the environment is represented in the interpreter has been modified to allow the status of multiple contracts to be stored simultaneously. In the version presented for LOPSTR, the environment was represented as a three-element tuple: G, M and L.
To take multiple contracts into account, the environment is now represented as a list of pairs (key, environment) in this version. The key is a combination of the contract name and its associated address.  The environment is the tuple representing the status of that contract.
