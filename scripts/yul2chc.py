import json
import subprocess
import os
import tempfile

import re
import sys


#read and count the slots for global memory 

SOL_KEYWORDS = {
    'public','private','internal','external','view','pure','payable',
    'virtual','override','returns','indexed','storage','memory',
    'constant','immutable','event','function','modifier','constructor',
    'enum','struct','library','interface','using','mapping','import'
}

def remove_comments(src: str) -> str:
    src = re.sub(r'/\*.*?\*/', '', src, flags=re.DOTALL)
    src = re.sub(r'//.*?$', '', src, flags=re.MULTILINE)
    return src

def find_contract_block(src: str, contract_name: str):
    pat = re.compile(r'\bcontract\s+' + re.escape(contract_name) + r'\b')
    m = pat.search(src)
    if not m:
        return None
    start_idx = m.end()
    brace_open = src.find('{', start_idx)
    if brace_open == -1:
        return None
    idx = brace_open + 1
    depth = 1
    N = len(src)
    while idx < N and depth > 0:
        if src[idx] == '{':
            depth += 1
        elif src[idx] == '}':
            depth -= 1
        idx += 1
    if depth != 0:
        return None
    block = src[brace_open+1: idx-1]
    return block

def split_top_level_statements(block: str):
    stmts = []
    cur = []
    depth_paren = 0
    depth_brace = 0
    depth_bracket = 0
    for ch in block:
        if ch == '(':
            depth_paren += 1
        elif ch == ')':
            if depth_paren > 0: depth_paren -= 1
        elif ch == '{':
            depth_brace += 1
        elif ch == '}':
            if depth_brace > 0: depth_brace -= 1
        elif ch == '[':
            depth_bracket += 1
        elif ch == ']':
            if depth_bracket > 0: depth_bracket -= 1
        if ch == ';' and depth_paren == 0 and depth_brace == 0 and depth_bracket == 0:
            stmts.append(''.join(cur).strip())
            cur = []
        else:
            cur.append(ch)
    tail = ''.join(cur).strip()
    if tail:
        stmts.append(tail)
    return stmts

def is_declaration_statement(stmt: str):
    skip_starts = ('function','event','modifier','enum','struct','constructor','receive','fallback','using','import','library','interface')
    s = stmt.strip()
    if not s:
        return False
    low = s.lstrip().split(None,1)[0].lower()
    if low in skip_starts:
        return False
    return True

def find_variable_names(stmt: str):
    pattern = re.compile(r'\b([A-Za-z_][A-Za-z0-9_]*)\b\s*(?=(=|,|$))')
    names = []
    for m in pattern.finditer(stmt):
        name = m.group(1)
        if name in SOL_KEYWORDS:
            continue
        names.append((name, m.start(1)))
    return names

def extract_type_for_variable(stmt: str, var_start_idx: int):
    left = stmt[:var_start_idx].strip()
    if not left:
        return ''
    tokens = left.split()
    while tokens and tokens[-1] in SOL_KEYWORDS:
        tokens.pop()
    if not tokens:
        return ''
    type_str = ' '.join(tokens)
    return type_str.strip()

def slots_for_type(type_str: str):
    ts = type_str.strip()
    if not ts:
        return 0
    if re.search(r'\bconstant\b', ts) or re.search(r'\bimmutable\b', ts):
        return 0
    if re.search(r'\bmapping\s*\(', ts):
        return 1
    # dynamic array [] -> 1
    if re.search(r'\[\s*\]', ts):
        return 1
    # fixed-size arrays: [n]
    sizes = re.findall(r'\[\s*(\d+)\s*\]', ts)
    if sizes:
        prod = 1
        for s in sizes:
            prod *= int(s)
        return prod
    # default simple type -> 1
    return 1

def count_storage_slots_from_block(contract_block: str):
    block_no_comments = remove_comments(contract_block)
    stmts = split_top_level_statements(block_no_comments)
    total = 0
    details = []
    for stmt in stmts:
        if not is_declaration_statement(stmt):
            continue
        if re.search(r'\bconstant\b', stmt) or re.search(r'\bimmutable\b', stmt):
            continue
        var_names = find_variable_names(stmt)
        if not var_names:
            continue
        for name, start_idx in var_names:
            t = extract_type_for_variable(stmt, start_idx)
            s = slots_for_type(t)
            total += s
            details.append((name, t, s))
    return total, details

def count_storage_slots_from_file(sol_path: str, contract_name: str):
    contract_name = contract_name.split(':')[-1].strip()
    try:
        with open(sol_path, 'r', encoding='utf-8') as f:
            src = f.read()
    except Exception as e:
        print(f"[ERROR] Unable to open {sol_path}: {e}", file=sys.stderr)
        return None, None
    block = find_contract_block(src, contract_name)
    if block is None:
        return None, None
    total, details = count_storage_slots_from_block(block)
    return total, details







############################################################################################

                            #Run the entire pipeline#

############################################################################################



def main():
    input_sol = input("Enter the full path to the source code input file: ")
    input_json = input("Enter the full path to the JSON input file: ")
    output = input("Enter the full path for the final output file: ")
    c_name = input("contract name: ")


    base, ext = os.path.splitext(c_name)
    replace_ext= ".txt"
    final_output = output + base + replace_ext

    with open(input_json, 'r') as f:
        data = json.load(f)

    with open(final_output, 'w') as fout:
        fout.write("")

    # for each contract in JSON
    for contract_name, contract_data in data.items():
        print(f"Processing contract: {contract_name}")

        # create a temporary JSON file containing only the data for this contract
        with tempfile.NamedTemporaryFile(delete=False, mode='w', suffix='.json') as temp_file:
            temp_json_path = temp_file.name
            json.dump({contract_name: contract_data}, temp_file, indent=4)

        # create a temporary output file for the second script
        with tempfile.NamedTemporaryFile(delete=False, mode='w', suffix='.pl') as temp_output_file:
            temp_output_path = temp_output_file.name

        # call generate_facts script passing:
        # - the temporary JSON file as input,
        # - the temporary file for output,
        # - the name of the contract to be processed
        cmd = ["python", "C:/Users/giuli/OneDrive/Desktop/Visiting/poposta lavoro/test_assert/ex_call/generate_facts.py", temp_json_path, temp_output_path, contract_name]

        subprocess.run(cmd, check=True)

        # Read the output generated for this contract
        with open(temp_output_path, 'r') as fout:
            contract_output = fout.read()

        # Appends the comment with the contract name and result to the final file
        with open(final_output, 'a') as fout:
            fout.write(f"% {contract_name} contract\n")
            fout.write(contract_output)
            fout.write("\n\n")

        
        # Delete temporary files
        os.remove(temp_json_path)
        os.remove(temp_output_path)


        total_slots, details = count_storage_slots_from_file(input_sol, contract_name)
        if total_slots is None:
            total_slots = 0
        insert_line = f"total positions = {total_slots}\n"

        with open(final_output, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        header = f"% {contract_name} contract"

        last_header_idx = None
        for i, L in enumerate(lines):
            if L.strip() == header:
                last_header_idx = i

        start_search = last_header_idx if last_header_idx is not None else 0
        inserted = False
        for i in range(start_search, len(lines)):
            if re.search(r'\bglobals\b', lines[i]):
                lines.insert(i, insert_line)
                inserted = True
                break

        if not inserted:
            lines.insert(0, insert_line)

        with open(final_output, 'w', encoding='utf-8') as f:
            f.writelines(lines)
        

    print(f"Final output original written to: {final_output}")


    # replace_character.py
    cmd = ["python", "C:/Users/giuli/OneDrive/Desktop/Visiting/poposta lavoro/test_assert/ex_call/replace_character.py", final_output]

    subprocess.run(cmd, check=True)


if __name__ == "__main__":
    main()
