import json
import sys

def extract_signatures(contract_data):
    signatures = []
    Zero = "0" * 56  
    # for each subObject
    for subname, subobj in contract_data.get("subObjects", {}).items():
        if "deployed" not in subname:
            continue

        blocks = subobj.get("blocks", [])
        lookup = {b["id"]: b for b in blocks}

        # recursion to follow jumps to the true caller
        def resolve_fn_name(block_id):
            blk = lookup.get(block_id, {})
            instrs = blk.get("instructions", [])
            # 1) search directly for a fun call
            for instr in instrs:
                op = instr.get("op", "")
                if op.startswith("external_fun_"):
                    return op
            # 2) if there are no instructions, or it is not yet a call,
            #  look at the exit to follow the jump
            exit_info = blk.get("exit", {})
            t = exit_info.get("type")
            if t == "Jump":
                return resolve_fn_name(exit_info["targets"][0])
            if t == "ConditionalJump":
                # try the true branch first 
                name = resolve_fn_name(exit_info["targets"][0])
                if name:
                    return name
                # otherwise also look at the false branch
                return resolve_fn_name(exit_info["targets"][1])
            # 'found nothing
            return None

        # extract the selectors from the ConditionalJump with eq
        for blk in blocks:
            ex = blk.get("exit", {})
            if ex.get("type") != "ConditionalJump":
                continue
            for instr in blk.get("instructions", []):
                if instr.get("op") == "eq":
                    selector = instr["in"][0]
                    selector_adj = selector + Zero
                    target = ex["targets"][1]
                    fn_name = resolve_fn_name(target)
                    signatures.append((fn_name, selector_adj))

    return signatures

if len(sys.argv) >= 4:
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    contract_to_process = sys.argv[3]
else:
    input_file = input("Enter the full path to the JSON input file: ")
    output_file = input("Enter the full path output file: ")
    contract_to_process = input("Enter the contract name to process: ")

def parse_yul_ir(file_path):
    try:
        with open(file_path, 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        print(f"Error: the {file_path} file has not been found.")
        return None, None, None, None
    except json.JSONDecodeError:
        print(f"Error: the {file_path} file is not a JSON.")
        return None, None, None, None

    # use the name of the contract passed as a parameter
    if contract_to_process not in data:
        print(f"Error: contract {contract_to_process} not found in JSON.")
        return None, None, None, None
    contract_data = data[contract_to_process]

    signatures = extract_signatures(contract_data)

    at_clauses = []       # List of 'at(...)' facts
    nextlab_clauses = []  # List of 'nextlab(...)' facts
    functions = []        # List of functions with prefix e entry point (ordine cronologico)

    # Extract blocks from the main object
    main_blocks = contract_data.get(next(iter(contract_data.keys())), {}).get("blocks", [])
    obj_data = contract_data.get(next(iter(contract_data.keys())), {})

    # Get sub-objects (e.g., deployed component)
    subobjects = contract_data.get("subObjects", {})

    # Find the deployed component key
    deployed_key = next((key for key in subobjects.keys() if "deployed" in key), None)
    if not deployed_key:
        print("Error: the 'deployed' part was not found in the contract structure.")
        return None, None, None, None

    deployed_data = subobjects[deployed_key]

    # Initialize contract global environment set
    contract_global_env = set()

    def extract_globals(blocks, only_constructor=False):
        for block in blocks:
            for instr in block.get("instructions", []):
                op = instr.get("op", "")
                inputs = instr.get("in", [])
                if only_constructor:
                    if op in {"sload", "sstore"}:
                        contract_global_env.add(f"{op}[{','.join(inputs)}]")
                    elif "offset" in op:
                        if len(inputs) == 2:
                            contract_global_env.add(f"{inputs[1]}")

    def extract_from_constructor(functions_dict):
        for func_name, func_data in functions_dict.items():
            if func_name.startswith("constructor"):
                extract_globals(func_data.get("blocks", []), only_constructor=True)

    extract_from_constructor(contract_data.get(next(iter(contract_data.keys())), {}).get("functions", {}))
    extract_from_constructor(deployed_data.get("functions", {}))
    
    # Collect functions from il main object e dalla parte deployed.
    generated_functions = {}

    # a) functions in the main object ('obj')
    for func_name, func_data in obj_data.get("functions", {}).items():
        arguments = func_data.get("arguments", [])
        outputs = func_data.get("out", [])
        inputs = func_data.get("in", [])
        entry_block = f"obj_{func_name}_{func_data['entry']}_1"
        functions.append(("obj", func_name, arguments, outputs, entry_block, func_data.get("blocks", [])))
        if func_name not in generated_functions:
            generated_functions[func_name] = {}
        generated_functions[func_name]["obj"] = {
            "name": f"obj_{func_name}",
            "arguments": arguments,
            "inputs": inputs,
            "outputs": outputs,
            "entry": entry_block,
            "numoutputs": func_data.get("numReturns", 0)
        }

    # b) Functions in the deployed part ('subO')
    for func_name, func_data in deployed_data.get("functions", {}).items():
        arguments = func_data.get("arguments", [])
        inputs = func_data.get("in", [])
        outputs = func_data.get("out", [])
        entry_block = f"subO_{func_name}_{func_data['entry']}_1"
        functions.append(("subO", func_name, arguments, outputs, entry_block, func_data.get("blocks", [])))
        if func_name not in generated_functions:
            generated_functions[func_name] = {}
        generated_functions[func_name]["subO"] = {
            "name": f"subO_{func_name}",
            "arguments": arguments,
            "inputs": inputs,
            "outputs": outputs,
            "entry": entry_block,
            "numoutputs": func_data.get("numReturns", 0)
        }
    
    def extract_local_vars(blocks):
        """Extracts local variables used in blocks."""
        local_vars = set()
        for block in blocks:
            for instr in block.get("instructions", []):
                for var in instr.get("out", []):
                    local_vars.add(var)
        return list(local_vars)
    
    
    def process_blocks(blocks, prefix, function_arguments):
        """Processes each block to generate CLP facts (at and nextlab).
           Generates a ret clause at the end of the block even if there are no return values
        """
        # determines the current scope: e.g. "obj" o "subO"
        current_scope = prefix.split('_')[0]

        builtin_ops = { "memoryguard", "caller", "calldatasize", "calldataload", "callvalue",
                       "datasize", "dataoffset", "sload", "not", "shl", "address",
                       "balance", "slt", "mload", "iszero", "lt", "gt", "eq", "neq",
                       "shr", "add", "sub", "mul", "div", "mod", "and", "or", "xor", 
                       "returndatasize", "gas", "extcodesize", 
                       "codesize", "extcodecopy", "extcodehash", "log0", "timestamp" , "create2",
                       "returndatacopy", "create"
                        }
        
        builtin_ops2 = { "sstore", "mstore", "mstore8","codecopy", "calldatacopy", 
                        "log0", "log1", "log2", "log3", "log4" }
        
        builtin_ops3 = { "call", "callcode", "delegatecall", "staticcall"}

        last_cj_index = None

        for block in blocks:
            block_id = block['id']
            instructions = block.get('instructions', [])
            exit_info = block.get('exit', {})
            return_values = exit_info.get('returnValues', []) if exit_info.get('type') == 'FunctionReturn' else []
            block_label_prefix = f"{prefix}_{block_id}"
            last_label = None
            entries = block.get('entries', [])
            


            # If there are no instructions, it still generates a ret clause
            if not instructions and exit_info.get('type') != 'Jump':
                #ret_label = f"{block_label_prefix}_1"
                ret_label = f"{prefix}_ret"

                # ── before issuing the ret, 'correct the CJ if necessary ──
                if last_cj_index is not None:
                    at_clauses[last_cj_index] = at_clauses[last_cj_index] \
                        .replace(f'"{block_label_prefix}_{len(instructions)+1}"',
                                f'"{ret_label}"')
                    last_cj_index = None

                if return_values:
                    at_clauses.append(f"at(\"{ret_label}\", ret([{','.join(return_values)}])).")
                else:
                    at_clauses.append(f"at(\"{ret_label}\", ret([])).")
                if last_label:
                    nextlab_clauses.append(f"nextlab(\"{last_label}\", \"{ret_label}\").")
                last_label = ret_label

            if instructions:
                for index, instr in enumerate(instructions):
                    op = instr['op']
                    inputs = instr.get('in', [])
                    outputs = instr.get('out', [])
                    label = f"{block_label_prefix}_{index + 1}"
                    
                    # built-in (group 1)
                    if op in builtin_ops:
                        if not inputs and outputs:
                            at_clauses.append(
                                f"at(\"{label}\", asgn(var({outputs[0]}), expr({op})))."
                            )
                        elif inputs and outputs:
                            at_clauses.append(
                                f"at(\"{label}\", asgn(var({outputs[0]}), expr({op}([{', '.join(inputs)}]))))."
                            )
                        else:
                            at_clauses.append(
                                f"at(\"{label}\", {op}([{', '.join(inputs)}]))."
                            )
                    # built-in (group 2)
                    elif op in builtin_ops2:
                        if inputs: 
                            at_clauses.append(
                                f"at(\"{label}\", {op}([{', '.join(inputs)}]))."
                            )
                        else:
                            at_clauses.append(
                                f"at(\"{label}\", {op})."
                            )
                    elif op == "PhiFunction":
                        at_clauses.append(
                            f"at(\"{label}\", asgn(var({outputs[0]}), expr(phiFunction([{inputs[0]}]), {entries[0]})))."
                        )
                        at_clauses.append(
                            f"at(\"{label}\", asgn(var({outputs[0]}), expr(phiFunction([{inputs[1]}]), {entries[1]})))."
                        )

                    elif op in builtin_ops3:
                        at_clauses.append(
                            f"at(\"{label}\", {op}([{', '.join(inputs)}], var({outputs[0]})))."
                        )    
                    # Handling of function calls: checking whether a function with the same prefix exists.
                    elif op in generated_functions:
                        # If a function with the current prefix exists, use it
                        if current_scope in generated_functions[op]:
                            func_details = generated_functions[op][current_scope]
                        else:
                            # Altrimenti, se disponibile una sola versione, la uso
                            func_details = list(generated_functions[op].values())[0]
                        inputs_list = f"[{', '.join(inputs)}]" if inputs else "[]"
                        outputs_list = f"[{', '.join(outputs)}]" if outputs else "[]"
                        at_clauses.append(
                            f"at(\"{label}\", fun_call({func_details['name']}, {inputs_list}, {outputs_list}))."
                        )
                    else:
                        if not inputs and not outputs:    
                            at_clauses.append(
                                f"at(\"{label}\", {op})."
                            )
                        else:
                            at_clauses.append(
                                f"at(\"{label}\", {op}([{', '.join(inputs)}]))."
                            )

                    # Link the previous label to the current one
                    if last_label:
                        nextlab_clauses.append(f"nextlab(\"{last_label}\", \"{label}\").")
                    last_label = label

                # Block exit management
                if exit_info.get('type') == 'Jump':
                    target = f"{prefix}_{exit_info['targets'][0]}_1"
                    jump_label = f"{block_label_prefix}_{len(instructions) + 1}"
                    at_clauses.append(f"at(\"{jump_label}\", goto(\"{target}\")).")
                    if last_label:
                        nextlab_clauses.append(f"nextlab(\"{last_label}\", \"{jump_label}\").")
                    last_label = jump_label
                elif exit_info.get('type') == 'ConditionalJump':
                    cond = exit_info['cond']
                    true_target = f"{prefix}_{exit_info['targets'][0]}_1"
                    false_target = f"{prefix}_{exit_info['targets'][1]}_1"
                    jump_label = f"{block_label_prefix}_jump"
                    at_clauses.append(f"at(\"{jump_label}\", cj(var({cond}), \"{true_target}\", \"{false_target}\")).")

                    last_cj_index = len(at_clauses) - 1 

                    if last_label:
                        nextlab_clauses.append(f"nextlab(\"{last_label}\", \"{jump_label}\").")
                    last_label = jump_label

                elif exit_info.get('type') == 'FunctionReturn':
                    not_ret_label = f"{block_label_prefix}_{len(instructions) + 1}"
                    ret_label = f"{prefix}_ret"
                    
                    if last_cj_index is not None:
                        # replace only on that line
                        at_clauses[last_cj_index] = (
                            at_clauses[last_cj_index]
                            .replace(f'"{not_ret_label}"', f'"{ret_label}"')
                        )
                    last_cj_index = None

                    if return_values:
                        at_clauses.append(f"at(\"{ret_label}\", ret([{','.join(return_values)}])).")
                    else:
                        at_clauses.append(f"at(\"{ret_label}\", ret([])).")
                    if last_label:
                        nextlab_clauses.append(f"nextlab(\"{last_label}\", \"{ret_label}\").")
                    last_label = ret_label

            elif not instructions and exit_info.get('type') == 'Jump':
                    target = f"{prefix}_{exit_info['targets'][0]}_1"
                    jump_label = f"{block_label_prefix}_{len(instructions) + 1}"
                    at_clauses.append(f"at(\"{jump_label}\", goto(\"{target}\")).")
                    if last_label:
                        nextlab_clauses.append(f"nextlab(\"{last_label}\", \"{jump_label}\").")
                    last_label = jump_label   

    updated_functions = []
    # Process each function: extract local variables, update details, and process blocks.
    for func_prefix, func_name, arguments, outputs, entry, blocks in functions:
        local_vars = extract_local_vars(blocks)
        updated_functions.append((func_prefix, func_name, arguments, local_vars, f"\"{entry}\""))
        process_blocks(blocks, f"{func_prefix}_{func_name}", arguments)
    
    # to create the function definition for the runtime part
    if deployed_data.get("blocks"):
        deployed_local_vars = extract_local_vars(deployed_data.get("blocks", [])) 
        first_block_id = deployed_data["blocks"][0]["id"]
        deployed_entry = f"{deployed_key}_{first_block_id}_1"
        updated_functions.append(
                (   "r",
                    deployed_key,             
                    [],                       
                    deployed_local_vars,      
                    f"\"{deployed_entry}\"")  
            )

    def generate_init_contract(blocks):
        """Generates a special function called init_contract for contract initialisation.
           When a constructor operator is found, processing of subsequent instructions is interrupted
        """
        local_vars = extract_local_vars(blocks)
        func_prefix = "init"
        func_name = "contract"
        local_vars = list(local_vars)
        entry_block = f"init_contract_{blocks[0]['id']}_1" if blocks else None
        if entry_block:
            functions.append((func_prefix, func_name, [], [], entry_block, []))
            updated_functions.append((func_prefix, func_name, [], local_vars, f"\"{entry_block}\""))
            processed_blocks = []
            found_constructor = False
            for block in blocks:
                block_id = block["id"]
                instructions = block.get("instructions", [])
                exit_info = block.get("exit", {})
                processed_instructions = []
                for instr in instructions:
                    processed_instructions.append(instr)
                    if instr.get("op", "").startswith(f"constructor_"):
                        found_constructor = True
                        break
                processed_blocks.append({
                    "id": block_id,
                    "instructions": processed_instructions,
                    "exit": block.get("exit", {})
                })
                if found_constructor and exit_info.get("type") == "ConditionalJump":
                    targets = exit_info.get("targets", [])
                    for target_id in targets:
                        target_block = next((b for b in blocks if b["id"] == target_id), None)
                        if target_block:
                            processed_blocks.append({
                                "id": target_block["id"],
                                "instructions": target_block["instructions"],
                                "exit": target_block.get("exit", {})
                            })
                    break
            for block in processed_blocks:
                process_blocks([block], "init_contract", [])
        return blocks

    def insert_nextlab_after_init(at_clauses):
        labels = [clause.split("(\"")[1].split("\",")[0] for clause in at_clauses]
        first = next((label for label in labels if not (label.startswith("subO") or label.startswith("obj") or label.startswith("init"))), None)
        last_init_labels = [label for label in labels if label.startswith("init")]
        last_init_labels = [
            label for label in last_init_labels
            if not any("revert" in clause and f"\"{label}\"" in clause for clause in at_clauses)
        ]
        last = last_init_labels[-1] if last_init_labels else None
        if first and last:
            prefix = last.split('_Block', 1)[0]
            next_lab = f"{prefix}_ret"
        
            last_init_index = max(i for i, clause in enumerate(at_clauses) if f"\"{last}\"" in clause)
            nextlab_clause = f"nextlab(\"{last}\", \"{next_lab}\")."
            at_clauses.insert(last_init_index + 1, nextlab_clause)
            at_clauses.insert(last_init_index + 2, f'at("{next_lab}", ret([])).')
            

    generate_init_contract(main_blocks)    
    process_blocks(deployed_data.get("blocks", []), deployed_key, [])
    insert_nextlab_after_init(at_clauses)
    
    # Combine the at and nextlab clauses while preserving the logical order
    combined_clauses = []  
    nextlab_dict = {clause.split("(\"")[1].split("\", \"")[0]: clause for clause in nextlab_clauses}
    for at_clause in at_clauses:
        label = at_clause.split("(\"")[1].split("\", ")[0]
        combined_clauses.append(at_clause)
        if label in nextlab_dict:
            combined_clauses.append(nextlab_dict[label])

    return combined_clauses, at_clauses, updated_functions, contract_global_env, signatures

def generate_clp(combined_clauses, functions, contract_global_env, signatures, output_file):
    """Writes the extracted information to the output file in CLP format"""
    with open(output_file, 'w') as file:
        file.write(f"signatures({signatures}).\n\n")
        file.write(f"globals([{contract_global_env}]).\n")
        for prefix, func_name, arguments, local_vars, entry in functions:
            arguments_vars = ", ".join(arguments)
            local_vars_str = ", ".join(local_vars)
            file.write(f"fun({prefix}_{func_name}, [{arguments_vars}], [{local_vars_str}], {entry}).\n")
        file.write("\n% Combined at and nextlab relations\n")
        for clause in combined_clauses:
            file.write(clause + "\n")
    print(f"Successfully generated CLP file: {output_file}")

def main():
    results = parse_yul_ir(input_file)
    if results is None:
        print("Error while processing JSON file.")
        return
    combined_clauses, _, functions, contract_global_env, signatures = results
    generate_clp(combined_clauses, functions, contract_global_env, signatures, output_file)


if __name__ == "__main__":
    main()
