import json
import subprocess
import os
import tempfile

def main():
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

    # For each contract in JSON
    for contract_name, contract_data in data.items():
        print(f"Processing contract: {contract_name}")

        # Create a temporary JSON file containing only the data for this contract
        with tempfile.NamedTemporaryFile(delete=False, mode='w', suffix='.json') as temp_file:
            temp_json_path = temp_file.name
            json.dump({contract_name: contract_data}, temp_file, indent=4)

        # Create a temporary output file for the second script
        with tempfile.NamedTemporaryFile(delete=False, mode='w', suffix='.pl') as temp_output_file:
            temp_output_path = temp_output_file.name

        # Call the second script passing:
        # - the temporary JSON file as input,
        # - the temporary file for output,
        # - the name of the contract to be processed
        cmd = ["python", "generate_facts.py", temp_json_path, temp_output_path, contract_name]

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

        
        

    print(f"Final output original written to: {final_output}")


    # Call the third script (replace_character.py) passing the input
    cmd = ["python", "replace_character.py", final_output]

    subprocess.run(cmd, check=True)


if __name__ == "__main__":
    main()
