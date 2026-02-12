import os
import re
import sys
from pathlib import Path
from typing import Optional, Set
import secrets
import tempfile
from typing import Match


# ff command line arguments have been passed, use them
if len(sys.argv) >= 2:
    input_file = sys.argv[1]
#else:
#    input_file = input("Enter the full path to the JSON input file: ")

def pulizia_phifunction(text):
    phi_pattern = re.compile(
        r'at\("(?P<label>[^\"]+)"\s*,\s*'
        r'asgn\(\s*(?P<var>[^,]+),\s*'
        r'expr\(phiFunction\((?P<args>\[[^\]]*\])\)(?:\s*,\s*(?P<block>Block\d+(?:_\d+)*))?\)\s*\)\s*\)\.'
    )
    goto_pattern = re.compile(
        r'at\("(?P<caller>[^\"]+)"\s*,\s*goto\(\s*"(?P<target>[^\"]+)"\s*\)\s*\)\.'
    )
    cj_pattern = re.compile(
        r'at\("(?P<caller>[^\"]+)"\s*,\s*'
        r'cj\(\s*(?P<cond>[^,]+)\s*,\s*"(?P<t1>[^\"]+)"\s*,\s*"(?P<t2>[^\"]+)"\s*\)\s*\)\.'
    )
    nextlab_pattern = re.compile(
        r'nextlab\("(?P<label>[^\"]+)"\s*,\s*"(?P<next>[^\"]+)"\)\.'
    )

    mapping = {}
    for m in phi_pattern.finditer(text):
        orig = m.group("label")
        blk = m.group("block")
        if not blk:
            bb = re.match(r'.*(Block\d+)(?:_\d+)*$', orig)
            blk = bb.group(1) if bb else ""
        main_n = int(re.match(r'Block(\d+)', blk).group(1)) if blk else 0
        suffix = f"_{main_n-1}" if main_n>0 else ""
        mapping[(orig, blk)] = orig + suffix

    out = []
    pending_phi = None

    for line in text.splitlines():
        m = phi_pattern.match(line)
        if m:
            orig = m.group("label")
            varp = m.group("var").strip()
            args = m.group("args").strip()
            blk = m.group("block") or re.match(r'.*(Block\d+)(?:_\d+)*$', orig).group(1)
            newlbl = mapping.get((orig, blk), orig)
            out.append(f'at("{newlbl}", asgn({varp}, expr(phiFunction({args})))).{blk}')
            pending_phi = (orig, newlbl)
            continue

        m = nextlab_pattern.match(line)
        if m and pending_phi and m.group("label") == pending_phi[0]:
            out.append(f'nextlab("{pending_phi[1]}", "{m.group("next")}").')
            pending_phi = None
            continue

        m = goto_pattern.match(line)
        if m:
            caller = m.group("caller")
            tgt    = m.group("target")
            raw_blk = re.match(r'.*(Block\d+(?:_\d+)*)', caller).group(1)
            primary = raw_blk.split("_")[0]
            newt = mapping.get((tgt, primary), tgt)
            out.append(f'at("{caller}", goto("{newt}")).')
            pending_phi = None
            continue

        m = cj_pattern.match(line)
        if m:
            caller = m.group("caller")
            cond   = m.group("cond").strip()
            t1, t2 = m.group("t1"), m.group("t2")
            raw_blk = re.match(r'.*(Block\d+(?:_\d+)*)', caller).group(1)
            primary = raw_blk.split("_")[0]
            def resolve(lbl):
                return mapping.get((lbl, primary), lbl)
            nt1, nt2 = resolve(t1), resolve(t2)
            out.append(f'at("{caller}", cj({cond}, "{nt1}", "{nt2}")).')
            pending_phi = None
            continue

        m = nextlab_pattern.match(line)
        if m:
            lab, nxt = m.group("label"), m.group("next")
            cand = next((new for ((o,blk),new) in mapping.items() if o==lab), None)
            if cand:
                out.append(f'nextlab("{cand}", "{nxt}").')
                pending_phi = None
                continue

        out.append(line)
        pending_phi = None

    return "\n".join(out)


def analyze_phi_blocks(text):
    """
    analyses text with suffixes '.BlockX' for phiFunctions,
    counts the total number of phi and occurrences of each block for each base function (before '_Block').
    removes suffixes for:
      1) functions with exactly 2 phiFunctions: all '.BlockX'
      2) functions with >2 phiFunctions: remove '.BlockX' only for blocks that appear only once
    """
    # pattern for phi lines with suffix .BlockX
    line_pattern = re.compile(
        r'at\("(?P<func>.+?)_Block\d+(?:_\d+)*".*?\)\.(?P<blk>Block\d+)'
    )

    funcs = {}  # func -> list of blk occurrences
    # collect data
    for line in text.splitlines():
        m = line_pattern.search(line)
        if m:
            func = m.group('func')
            blk = m.group('blk')
            funcs.setdefault(func, []).append(blk)

    # generate counts
    stats = {func: {'total': len(blks), 'per_blk': {}} for func, blks in funcs.items()}
    for func, blks in funcs.items():
        for b in blks:
            stats[func]['per_blk'][b] = stats[func]['per_blk'].get(b, 0) + 1

    # reconstruct text
    out = []
    for line in text.splitlines():
        m = line_pattern.search(line)
        if not m:
            out.append(line)
        else:
            func = m.group('func')
            blk = m.group('blk')
            total = stats[func]['total']
            count = stats[func]['per_blk'][blk]
            # if total==2 always remove, or if >2 and count==1
            if total == 2 or (total > 2 and count == 1):
                # removes the .BlockX suffix
                new_line = re.sub(r'\)\.Block\d+$', ').', line)
                out.append(new_line)
            else:
                out.append(line)
    return "\n".join(out)

def fix_phi_nextlab_links(text):
    import re

    lines = text.splitlines()

    at_re = re.compile(
    r'^at\("(?P<label>[^"]+)"\s*,.*\)\.(?P<branch>Block\d+(?:_\d+)*)$'
    )
    nextlab_re = re.compile(
        r'^nextlab\("(?P<frm>[^"]+)"\s*,\s*"(?P<to>[^"]+)"\)\.$'
    )

    # 1. Collect phiFunctions in order by (func, branch)
    groups = {}
    for line in lines:
        m = at_re.match(line.strip())
        if m:
            label = m.group("label")
            branch = m.group("branch")
            func = label.split("_Block", 1)[0]
            key = (func, branch)
            groups.setdefault(key, []).append(label)

    # 2. Create output by correcting nextlab following at(...)
    out = []
    i = 0
    while i < len(lines):
        line = lines[i]
        m = at_re.match(line.strip())

        if m:
            label = m.group("label")
            branch = m.group("branch")
            func = label.split("_Block", 1)[0]
            key = (func, branch)
            seq = groups.get(key, [])
            idx = seq.index(label)

            # remove the BlockX suffix
            out.append(re.sub(r"\)\.Block\d+(?:_\d+)*$", ").", line))

            # check nextlab immediately afterwards
            if idx < len(seq) - 1:
                expected_to = seq[idx + 1]
                next_line = lines[i + 1].strip() if i + 1 < len(lines) else ""
                nm = nextlab_re.match(next_line)
                if nm and nm.group("frm") == label:
                    # Correct if it pointed to the wrong label
                    if nm.group("to") != expected_to:
                        out.append(f"nextlab('{label}', '{expected_to}').")
                    else:
                        out.append(next_line)
                    i += 2
                    continue
                else:
                    out.append(f"nextlab('{label}', '{expected_to}').")
        else:
            out.append(line)

        i += 1

    return "\n".join(out)

def collect_at_labels(text: str) -> Set[str]:
    """
    extracts all labels present in the facts at('Label', ...).
    """
    pat = re.compile(r'at\(\s*"(?P<label>[^"]+)"')
    return {m.group('label') for m in pat.finditer(text)}

def fix_fun_labels_in_text(text: str) -> str:
    """
    For each statement
      fun(F, Args, Rets, "F_Block0_1")
    check:
      - if "F_Block0_1" is NOT in at_labels
      - if, on the other hand, "F_ret" is in at_labels
    in this case, replace "F_Block0_1" with "F_ret"
    """
    at_labels = collect_at_labels(text)

    # pattern to capture tuples fun(..., 'Label')
    fun_pat = re.compile(
        r'''fun\(\s*
             (?P<fun>[A-Za-z0-9_$]+)       
           (\s*,\s*\[[^\]]*\]){2}       
           \s*,\s*
             "(?P<label>[^"]+)"          
           \s*\)''',
        re.VERBOSE
    )

    def repl(m: re.Match) -> str:
        f   = m.group('fun')
        lbl = m.group('label')
        block_lbl = f + "_Block0_1"
        ret_lbl   = f + "_ret"
        if lbl == block_lbl and block_lbl not in at_labels and ret_lbl in at_labels:
            return m.group(0).replace(f'"{block_lbl}"', f'"{ret_lbl}"')
        return m.group(0)

    return fun_pat.sub(repl, text)



def replace_characters_and_add_lines(input_path, output_path):
    """
    1. reads the specified file, removes the '{' and '}' characters
    2. adds two initial lines,
    3. wraps words containing '$' in single quotes 
    4. For operations that handle an offset (memory, fun_call, calldataload)
       ensures that the offset is enclosed in quotes (if not already) and then
       immediately wrapped the proper wrapper (functor):
        
        The operations handled are: 
        a) functor of type var()
            - asgn operation
            - other builtin function (add, iszero, ecc )

        b) functor of type off('')
            - sstore([value, offset], [optional_args])
            - sload([offset])
            - Operations via fun_call:
                - If the function name contains 'update_storage_value',
                    the arguments are assumed to be [value, offset] and the second argument is modified.
                - If the function name contains 'read_from_storage_split_offset',
                    the arguments are assumed to be [offset] and that one parameter is modified.
            - Calldataload operation:
                    calldataload([offset])

        c) functor of type mem('')
        - Memory operations:
            - mstore([value, offset], [optional_args])
            - mload([offset])
        - operation that works on memory: 
            - kekka256(n, p)        
            - calladatacopy(s, f, t)  
            - codecopy(s, f, t)       
            - mcopy(s, f, t)          
    """

    
    # characters to be removed
    characters_to_remove = ["{", "}" ] #, "$"]

    # rows to be added at the head of the file
    header_lines = [
        #":- dynamic at/2.",
        #":- discontiguous at/2.",
        #":- discontiguous nextlab/2."
        ":- dynamic at/3.",
        ":- discontiguous at/3.",
        ":- discontiguous nextlab/3.",
        ":- discontiguous globals/2.",
        ":- discontiguous signatures/2.",
        ":- discontiguous memory/2.",
        ":- discontiguous fun/5."
    ]


    filename =os.path.splitext(os.path.basename(input_file))[0]


    footer_lines = [f":- include('{filename}.aux.pl')."]
    
    hex_pat = re.compile(r'0x[0-9A-Fa-f]+')
    
    #utility function to decide whether to wrap the offset
    def maybe_wrap_offset(offset, wrapper="off"):
        offset = offset.strip()
        #if the offset is a variable such as 'v<number>', do nothing
        if re.fullmatch(r'v\d+', offset):
            return offset
        if hex_pat.fullmatch(offset):
            return f"{wrapper}({offset})"
       #if it is not already wrapped with superscripts, wrap it
        if not (offset.startswith("'") and offset.endswith("'")):
            offset = f"'{offset}'"
        # If it is not already wrapped in var(), we wrap it
        if not offset.startswith(f"{wrapper}("):
            return f"{wrapper}({offset})"
        return offset

    # MEMORY OPERATIONS
    #pattern for functions with two arguments (mstore, sstore)
    pattern_two_memory = re.compile(
        r'(?P<func>mstore|sstore)\(\[\s*(?P<value>[^,\]]+)\s*,\s*(?P<offset>[^\]]+)\s*\]'
        r'(?:\s*,\s*\[[^\]]*\]\s*)?\)'
    )
    #patterns for functions with only one argument (mload, sload)
    pattern_one_memory = re.compile(
        r'(?P<func>mload|sload)\(\[\s*(?P<offset>[^\]]+)\s*\]\)'
    )
    
    def replace_two_memory(match):
        func = match.group('func')
        value = match.group('value')
        offset = match.group('offset')
        new_offset = maybe_wrap_offset(offset)
        if func == "sstore":
            new_offset = maybe_wrap_offset(offset, wrapper="off")
        else: #mstore
            new_offset = maybe_wrap_offset(offset, wrapper="mem")
        return f"{func}([{value}, {new_offset}])"
    
    def replace_one_memory(match):
        func = match.group('func')
        offset = match.group('offset')
        # var is used for mload, off is used for sload
        if func == "sload":
            new_offset = maybe_wrap_offset(offset, wrapper="off")
        else:  
            new_offset = maybe_wrap_offset(offset, wrapper="mem")
        return f"{func}([{new_offset}])"
    
    # --- calldataload ---
    pattern_calldataload = re.compile(
        r'(?P<func>calldataload)\(\[\s*(?P<offset>[^\]]+)\s*(?:,\s*\[(?P<extra>[^\]]*)\])?\s*\)'
    )
    
    def replace_calldataload(match):
        func = match.group('func')
        offset = match.group('offset')
        new_offset = maybe_wrap_offset(offset, wrapper="off")
        return f"{func}([{new_offset}])"
    
    # --- revert ---
    pattern_revert = re.compile(
        r'revert\(\[\s*(?P<input1>[^,\]]+)\s*,\s*(?P<input2>[^,\]]+)\s*\]\)'
    )

    def replace_revert(match):
        input1 = match.group('input1')
        input2 = match.group('input2')
        new_input2 = maybe_wrap_offset(input2, wrapper="mem")
        return f"revert([{input1}, {new_input2}])"
    
    # --- return ---
    pattern_return = re.compile(
        r'return\(\[\s*(?P<input1>[^,\]]+)\s*,\s*(?P<input2>[^,\]]+)\s*\]\)'
    )

    def replace_return(match):
        input1 = match.group('input1')
        input2 = match.group('input2')
        new_input2 = maybe_wrap_offset(input2, wrapper="mem")
        return f"return([{input1}, {new_input2}])"


    
    # --- fun_call ---
       #pattern to capture calls to fun_call with three arguments:
    # - The first (fname) is the name of the function
    # - The second (args) is a list in square brackets
    # - The third (outputs) is a list in square brackets
    pattern_fun_call = re.compile(
        r'fun_call\(\s*(?P<fname>[^\s,()]+)\s*,\s*\[(?P<args>[^\]]+)\]\s*\)'
    )
    pattern_fun_call = re.compile(
        r'fun_call\(\s*(?P<fname>[^\s,()]+)\s*,\s*\[(?P<args>[^\]]+)\]\s*(?:,\s*\[(?P<extra>[^\]]*)\])?\s*\)'
    )
    
    def replace_fun_call(match):
        fname = match.group('fname')
        args_str = match.group('args')
        extra = match.group('extra')  # could be []
        #split comma-separated arguments
        args = [arg.strip() for arg in args_str.split(',') if arg.strip()]
        
        #if it is an update_storage_value call, the second parameter is modified
        if "update_storage_value" in fname:
            if len(args) < 2:
                return match.group(0)
            args[1] = maybe_wrap_offset(args[1], wrapper="off")
        #if it is a read_from_storage_split_offset call, the only parameter is modified
        elif "read_from_storage_split_offset" in fname:
            if len(args) != 1:
                return match.group(0)
            args[0] = maybe_wrap_offset(args[0], wrapper="off")
        else:
            return match.group(0)
            
        new_args_str = ", ".join(args)
        return f"fun_call({fname}, [{new_args_str}], [{extra}])"
    
    #---other ----
    # kekka256(n, p) --> p if it has offsets, they must be wrapped in mem('')
    pattern_kekka256 = re.compile(
        r'kekka256\(\s*(?P<n>[^,\)]+)\s*,\s*(?P<p>[^,\)]+)\s*\)'
    )
    
    def replace_kekka256(match):
        n = match.group('n')
        p = match.group('p')
        new_p = maybe_wrap_offset(p, wrapper="mem")
        return f"kekka256({n}, {new_p})"
    
    # calladatacopy(s, f, t) --> t if it has offsets, they must be wrapped in mem('')
    pattern_calladatacopy = re.compile(
        r'calladatacopy\(\s*(?P<s>[^,]+)\s*,\s*(?P<f>[^,]+)\s*,\s*(?P<t>[^,\)]+)\s*\)'
    )
    
    def replace_calladatacopy(match):
        s = match.group('s')
        f = match.group('f')
        t = match.group('t')
        new_t = maybe_wrap_offset(t, wrapper="mem")
        return f"calladatacopy({s}, {f}, {new_t})"
    
    # codecopy(s, f, t) --> t if it has offsets, they must be wrapped in mem('')
    pattern_codecopy = re.compile(
        r'codecopy\(\s*(?P<s>[^,]+)\s*,\s*(?P<f>[^,]+)\s*,\s*(?P<t>[^,\)]+)\s*\)'
    )
    
    def replace_codecopy(match):
        s = match.group('s').strip()
        f = match.group('f').strip()
        t = match.group('t').strip()

        if t.endswith(']'):
            inner, suffix = t[:-1], ']'
        else:
            inner, suffix = t, ''

        new_inner = inner if re.fullmatch(r'v\d+', inner) else maybe_wrap_offset(inner, wrapper="mem")
        new_t = new_inner + suffix

        return f"codecopy({s}, {f}, {new_t})"

    # mcopy(s, f, t) --> f and t if they have offsets, they must be wrapped in mem('')
    pattern_mcopy = re.compile(
        r'mcopy\(\s*(?P<s>[^,]+)\s*,\s*(?P<f>[^,]+)\s*,\s*(?P<t>[^,\)]+)\s*\)'
    )
    
    def replace_mcopy(match):
        s = match.group('s')
        f = match.group('f')
        t = match.group('t')
        new_f = maybe_wrap_offset(f, wrapper="mem")
        new_t = maybe_wrap_offset(t, wrapper="mem")
        return f"mcopy({s}, {new_f}, {new_t})"


    try:
        with open(input_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
        
        modified_lines = []
        for line in lines:
            #removes unwanted characters
            for ch in characters_to_remove:
                line = line.replace(ch, '')
            
            #Encloses words containing '$' in quotes
            #line = re.sub(r'(?<!\w)([A-Za-z0-9_]+\$[A-Za-z0-9_$]*)(?!\w)', r'"\1"', line)
            
            #applies substitutions for memory operations
            line = re.sub(pattern_two_memory, replace_two_memory, line)
            line = re.sub(pattern_one_memory, replace_one_memory, line)
            # Calldataload
            line = re.sub(pattern_calldataload, replace_calldataload, line)
            #fun_call per update_storage_value and read_from_storage_split_offset
            line = re.sub(pattern_fun_call, replace_fun_call, line)
            # revert
            line = re.sub(pattern_revert, replace_revert, line)
            # return
            line = re.sub(pattern_return, replace_return, line)

            #other
            # replacements for new operations
            line = re.sub(pattern_kekka256, replace_kekka256, line)
            line = re.sub(pattern_calladatacopy, replace_calladatacopy, line)
            line = re.sub(pattern_codecopy, replace_codecopy, line)
            line = re.sub(pattern_mcopy, replace_mcopy, line)
            
            modified_lines.append(line)
        
        final_content = "\n".join(header_lines) + "\n" + "".join(modified_lines) + "\n"  + "".join(footer_lines)
        with open(output_path, 'w', encoding='utf-8') as file:
            file.write(final_content)
        return final_content
    
    except FileNotFoundError:
        print(f"Error: The file '{input_path}' was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

def wrap_other_arguments(output_path):
    """
    reads the file and for each element contained in a list executes:
      - if the element is a hexadecimal number (e.g. 0x00), it wraps it in num(...)
      - ff the element is a variable (e.g. v0), wraps it in var(...)
    already wrapped elements (e.g. var('0x00')) are not changed
    """
    def wrap_elem(elem):
        elem = elem.strip()
        if elem.startswith("var(") or elem.startswith("num("):
            return elem
        if re.fullmatch(r'v\d+', elem):
            return f"var({elem})"
        if re.fullmatch(r'0x[0-9a-fA-F]+', elem):
            return f"num({elem})"
        return elem

    try:
        with open(output_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # identifies lists delimited by square brackets
        def process_list(match):
            inner = match.group(1)
            elems = [t.strip() for t in inner.split(',')]
            new_elems = [wrap_elem(t) for t in elems]
            return f"[{', '.join(new_elems)}]"
        
        new_content = re.sub(r'\[([^\[\]]+)\]', process_list, content)
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return new_content

    except FileNotFoundError:
        print(f"Error: The file '{output_path}' was not found.")
    except Exception as e:
        print(f"An error occurred in wrap_other_arguments: {e}")

def apply_phi_modification(output_path):

    try:
        with open(output_path, 'r', encoding='utf-8') as f:
            content = f.read()

        content = fix_fun_labels_in_text(content)    
        # apply the change for PhiFunction
        new_content = pulizia_phifunction(content)
        new_content2 = analyze_phi_blocks(new_content) 
        new_content3= fix_phi_nextlab_links(new_content2)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(new_content3)
        return new_content3
    except FileNotFoundError:
        print(f"Error: The file '{output_path}' was not found.")
    except Exception as e:
        print(f"An error occurred in apply_phi_modification: {e}")

def insert_init_call(output_path):
    deployed_pat = re.compile(r'at\("([^"]+_deployed_Block0_1)"')
    
    deployed_label = None
    with open(output_path, 'r', encoding='utf-8') as f:
        for line in f:
            m = deployed_pat.match(line.strip())
            if m:
                deployed_label = m.group(1)
                base_label = deployed_label.removesuffix("_Block0_1")
                break


    new_lines = []
    with open(output_path, 'r', encoding='utf-8') as f:
        for line in f:
            #stripped = line.strip()
            #pattern = re.compile(r'at\("(.+?)_init_contract_Block0_1"')
            pattern = re.compile(r'^at\("init_contract_Block0_1".*')
            init_c = pattern.search(line)
            if init_c:
            #if stripped.startswith('at("init_contract_Block0_1"'):
                #contract = init_c.group(1) 
                #new_lines.append(f'at("start_contract", fun_call({contract}_init_contract, [], [])).\n')
                new_lines.append(f'at("start_contract", fun_call(init_contract, [], [])).\n')
                new_lines.append(f'nextlab("start_contract", "runtime_contract").\n')
                new_lines.append(f'at("runtime_contract", fun_call(r_{base_label}, [], [])).\n')

            new_lines.append(line)
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        return "".join(new_lines)
    

def fix_globals_line(line: str) -> str:
    m = re.search(r'\bglobals\s*\(', line)
    if not m:
        return line
    
    start = m.end() - 1  
    depth = 0
    end = None
    for idx in range(start, len(line)):
        ch = line[idx]
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0:
                end = idx
                break
    if end is None:
        return line
    
    inner = line[start+1:end]
    # rimuove la virgola se è immediatamente prima di una ']'
    fixed_inner = re.sub(r',\s*(\])', r'\1', inner)
    return line[:start+1] + fixed_inner + line[end:]


def fix_memory_line(line: str) -> str:

    pattern = re.compile(r'memory\s*\(\s*\[\s*([^\]]*?)\s*\]\s*\)', flags=re.IGNORECASE)

    def repl(m: Match) -> str:
        inner = m.group(1)  
        elems = [e.strip() for e in inner.split(',') if e.strip() != '']

        target = '0x40'
        idx = None
        for i, e in enumerate(elems):
            if e.lower() == target:
                idx = i
                break

        if idx is None:
            return m.group(0)

        # insert after 0x40
        to_add = ['0x80', '0x128', '0xa0', '0xc0', '0xe0']

        new_elems = elems[:idx+1] + to_add + elems[idx+1:]
        new_inner = ', '.join(new_elems)

        whole = m.group(0)
        left_br = whole.find('[')
        right_br = whole.rfind(']')
        prefix = whole[:left_br+1]   
        suffix = whole[right_br:]    
        return prefix + new_inner + suffix

    return pattern.sub(repl, line)

    


def update_globals_and_memory(output_path):
    try:
        with open(output_path, 'r', encoding='utf-8') as f:
            content = f.read()


        off_keys = re.findall(r"off\(\s*'?(0x[0-9A-Fa-f]+|[^']+)'?\s*\)", content)
        mem_keys = re.findall(r"mem\(\s*'?(0x[0-9A-Fa-f]+|[^']+)'?\s*\)", content)

        globals_match = re.search(r'(globals\(\s*\[[^\]]*\]\s*\)\.\n?)', content)
        if globals_match:
            inside = re.search(r'\[\s*([^\]]*)\s*\]', globals_match.group(1)).group(1)
            current = [k.strip().strip("'\"") for k in inside.split(',') if k.strip()]
        else:
            current = []

        for k in off_keys:
            if k not in current:
                current.append(k)
        current = [k for k in current if k != "set()"]
        current = sorted(current)
        mem_keys = sorted(set(mem_keys))

        hex_pat = re.compile(r'0x[0-9A-Fa-f]+')
        def quote_key(k):
            return k if hex_pat.fullmatch(k) else f"'{k}'"
        
        characters = '0123456789abcd'
        # generate address
        #random_address = '0x' + ''.join(secrets.choice(characters) for _ in range(8)) 

        nonzero_chars = characters.replace('0', '')  # tutti i caratteri tranne '0'

        def generate_address(length=8):
            if length < 1:
                raise ValueError("length must be >= 1")
            if length == 1:
                return '0x' + secrets.choice(nonzero_chars)

            middle = ''.join(secrets.choice(characters) for _ in range(length - 2))
            return '0x' + secrets.choice(nonzero_chars) + middle + secrets.choice(nonzero_chars)

        
        random_address = generate_address(8)

        globals_line = f"globals([(address, {random_address}), {', '.join(quote_key(k) for k in current)}]).\n"
        memory_line = f"memory([{', '.join(quote_key(k) for k in mem_keys)}]).\n\n"

        globals_line = fix_globals_line(globals_line)
        memory_line = fix_memory_line(memory_line)

        content = re.sub(r'memory\(\s*\[[^\]]*\]\s*\)\.\n?', '', content)
        if globals_match:
            content = re.sub(
                r'(globals\(\s*\[[^\]]*\]\s*\)\.\n?)',
                globals_line + memory_line,
                content,
                count=1
            )
        else:
            content = globals_line + memory_line + content

        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return content

    except FileNotFoundError:
        print(f"Error: The file '{output_path}' was not found.")
    except Exception as e:
        print(f"An error occurred in update_globals_and_memory: {e}")



def replace_quote(output_path):
    try:
        with open(output_path, 'r', encoding='utf-8') as f:
            content = f.read()

        #Encloses words containing '$' in quotes
        content = re.sub(r'(?<!\w)([A-Za-z0-9_]+\$[A-Za-z0-9_$]*)(?!\w)', r'"\1"', content)        

        pattern = re.compile(r"(?<!')\"([^\"]*)\"(?!')")

        content = pattern.sub(r"'\1'", content)

        content = re.sub(r"''+", "'", content)

        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return content


    except FileNotFoundError:
        print(f"Error: The file '{output_path}' was not found.")
    except Exception as e:
        print(f"An error occurred in update_globals_and_memory: {e}")


##############################################################################

def split_contracts(full_text: str):
    """
    returns a list of tuples (header_line, contract_body_text)
    header_line is the line with "%" and the contract name,
    contract_body_text is all the text up to the next header or the end of the file (declarations and at, nextlab)
    """
    segments = []
    current_header = None
    current_lines = []

    for line in full_text.splitlines(keepends=True):
        m = re.match(r'^\%\s*(.+)$', line)
        if m:
            # store the contract under analysis
            if current_header is not None:
                segments.append((current_header, ''.join(current_lines)))
                current_lines = []
            current_header = line
        else:
            if current_header is not None:
                current_lines.append(line)
    if current_header is not None:
        segments.append((current_header, ''.join(current_lines)))
    return segments        



def update_address_file(filepath):
    """
        - Rreads the entire 'filepath' file
        - extracts in order:
                the addresses 0x... from each line containing "globals([(address, 0x...]"
                the names from each comment '% ...:NAME contract'
        - composes the tuple address([(val1,Name1), (val2,Name2), ...])
        - if the first line is already "address([…])", it replaces it; otherwise, it inserts it at the top
        - rewrites the file and returns the updated content
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        contex = f.read()

    # extract address from globals([...])
    vals = re.findall(r"globals\(\s*'[^']+'\s*,\s*\[\s*\(address\s*,\s*(0x[0-9A-Fa-f]+)\)", contex)
    #vals = re.findall(r"globals\(\s*[^,]+\s*,\s*\[\s*\(address\s*,\s*(0x[0-9A-Fa-f]+)\)", contex)

    # extract contract name form comment '% …:NAME contract'
    names = re.findall( r'%[^:\n]*:\s*([^ \n]+)\s*contract', contex, flags=re.IGNORECASE)
    
    names = ["'" + n.lower() + "'" for n in names]

    if not vals or not names:
        raise ValueError("Error, no address found")

    count = min(len(vals), len(names))
    pairs = [f'({vals[i]},{names[i]})' for i in range(count)]

    # write address([(…)]).
    #TO DO: modifica per togliere la virgola quando non ci sono offset 
    address_line = 'address([' + ','.join(pairs) + ']).\n\n'

    contex = re.sub(r'^\s*address\(\[.*?\]\)\.\s*\n*', '' , contex, flags=re.DOTALL)
   
    updated = address_line + contex

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(updated)

    return updated 



def insert_c_name(filepath: str, cname: str) -> None:
    """
    - reads the file, extracts the contract name from the comment "% ...:Contract name" 
    - read the contract address 
    - create contract_name = cname_address --> address is inserted as a unique element (olny the contract name is a problem in case of contracts with the same name)
    - inserts it as the first argument in signatures, globals, memory, fun, at, nextlab
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()

    #cname = cname.lower() 
    #m = re.search(r'%[^:\n]*:\s*([^ \n]+)\s*contract', text, flags=re.IGNORECASE)
    
    #address 
        addr = re.search(r"globals\(\s*\[\s*\(\s*address\s*,\s*(0x[0-9A-Fa-f]+)\s*\)\s*(?:,|\])", text, flags=re.IGNORECASE)
        address = addr.group(1).lower()

        cname = f"{cname}_{address}"

        #adds quotation marks around the contract name
        cname = f"'{cname}'"

    # pattern for replacements
    pat = re.compile(
        r'^(?P<indent>\s*)'
        r'(?P<pred>signatures|globals|memory|fun|at|nextlab)'
        r'\s*\(',
        flags=re.MULTILINE
    )
    
    # make the replacement
    def _repl(m: re.Match) -> str:
        #return f"{m.group('indent')}{m.group('pred')}('{cname}', "
        indent = m.group('indent')
        pred   = m.group('pred')
        return f"{indent}{pred}({cname}, "
    
    new_text = pat.sub(_repl, text)
 
 
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_text)


def add_missing_hex_positions_in_file(path: str, total_positions_pattern=r'\btotal positions\s*=\s*(\d+)', globals_keyword='globals'):
    """
    - find the line --> total positions = X
    - remove that line
    - find the globals(...) and complete the list with the missing hexadecimal values up to X (0 .. X-1)
    """
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # find "total positions = X"
    m_total = re.search(total_positions_pattern, content, flags=re.IGNORECASE)
    total_value = int(m_total.group(1))
    total_start = m_total.start()
    end_of_line = content.find('\n', m_total.end())
    if end_of_line == -1:
        total_end = m_total.end()
    else:
        total_end = end_of_line + 1

    # content WithOut the line  "total positions = X"
    content_wo_total = content[:total_start] + content[total_end:]
    globals_pos = content_wo_total.find(globals_keyword, total_start)
    if globals_pos == -1:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content_wo_total)
        return False

    paren_open = content_wo_total.find('(', globals_pos)
    depth = 0
    paren_close = None
    for i in range(paren_open, len(content_wo_total)):
        ch = content_wo_total[i]
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0:
                paren_close = i
                break
    
    globals_call = content_wo_total[paren_open:paren_close+1]
    list_open_rel = globals_call.find('[')
    list_open_abs = paren_open + list_open_rel
    depth_b = 0
    list_close_abs = None
    for i in range(list_open_abs, paren_close+1):
        ch = content_wo_total[i]
        if ch == '[':
            depth_b += 1
        elif ch == ']':
            depth_b -= 1
            if depth_b == 0:
                list_close_abs = i
                break
    
    list_text = content_wo_total[list_open_abs+1:list_close_abs] 

    hexs = re.findall(r'0x[0-9a-fA-F]+', list_text)
    existing = set()
    small_hex_lengths = []
    for h in hexs:
        try:
            v = int(h, 16)
        except ValueError:
            continue
        existing.add(v)
        if v < total_value:  
            small_hex_lengths.append(len(h) - 2)

    pad = max(2, max(small_hex_lengths) if small_hex_lengths else 2)

    desired = range(0, total_value)
    missing = [v for v in desired if v not in existing]

    if not missing:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content_wo_total)
        return True
    
    hex_strings = [f"0x{format(v, 'x').zfill(pad)}" for v in missing]

    inner = list_text
    if inner.strip() == '':
        new_inner = ', '.join(hex_strings)
    else:
        if re.search(r',\s*$', inner):
            new_inner = inner + ' ' + ', '.join(hex_strings)
        else:
            new_inner = inner + ', ' + ', '.join(hex_strings)

    new_content = (content_wo_total[:list_open_abs+1]
                   + new_inner
                   + content_wo_total[list_close_abs:])  

    with open(path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    return True



'''def main():
    base, ext = os.path.splitext(input_file)
    replace_ext= ".pl"
    output_path = base + replace_ext
    result_1 = replace_characters_and_add_lines(input_file, output_path)
    results = wrap_other_arguments(output_path)
    final_result = insert_init_call(output_path)
    final_result = update_globals_and_memory(output_path)
    final_result = apply_phi_modification(output_path)
    final_result = replace_quote(output_path)
    print(f"Final output replaced written to: {output_path}")
    if results is None or result_1 is None or final_result is None:
        print("Error while processing pl file.")

        return '''

def main_multi_contract(input_file):
    # read the file
    with open(input_file, 'r', encoding='utf-8') as f:
        full_text = f.read()

    # split it into various contracts
    contracts = split_contracts(full_text)
    if not contracts:
        print("No contract found.")
        return

    # prepare the output file
    base, _ = os.path.splitext(input_file)
    output_path = base + ".pl"
    final_output_parts = []

    # for each contract
    for header_line, body in contracts:
        m = re.search(r'%.*?:\s*([^\s\r\n]+)\s+contract', header_line, flags=re.IGNORECASE)
        cname = m.group(1).lower()

        #adds quotation marks around the contract name
        #cname = f"'{cname}'"  

        # create a temporary file
        with tempfile.NamedTemporaryFile('w+', suffix=".txt", delete=False) as tf_in:
            tf_in.write(body)
            tf_in.flush()

            # prepare the path 
            tf_out_path = tf_in.name + ".pl"

            # run the entire pipeline
            replace_characters_and_add_lines(tf_in.name, tf_out_path)
            wrap_other_arguments(tf_out_path)
            insert_init_call(tf_out_path)
            update_globals_and_memory(tf_out_path)
            apply_phi_modification(tf_out_path)
            replace_quote(tf_out_path)
            add_missing_hex_positions_in_file(tf_out_path)
            insert_c_name(tf_out_path, cname)

            # read the processed result
            with open(tf_out_path, 'r', encoding='utf-8') as f_out:
                processed = f_out.read()

        # add to the final output with a header that refers to the contract
        final_output_parts.append(header_line)
        final_output_parts.append(processed)
        final_output_parts.append("\n") 
        final_output_parts.append("\n") 


        # removal of temporary files
        os.remove(tf_in.name)
        os.remove(tf_out_path)

    #  write everything in a single .pl file
    with open(output_path, 'w', encoding='utf-8') as f:
        #update_address_file(output_path)
        f.writelines(final_output_parts)
        
    update_address_file(output_path)
    print(f"Final output replaced written to: {output_path}")

if __name__ == "__main__":
#   main()
    main_multi_contract(input_file)
    