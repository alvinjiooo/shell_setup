# python3 add_log.py some_file.cc 

import re
import fileinput
import argparse

def add_logging(code):
    """Adds logging lines to each class method and global function.

    Args:
        code: The C++ code string.

    Returns:
        The modified code string with logging lines added.
    """

    function_defs = re.findall(r"(?:\S+\s+)+\w+(?:\s*::\s*\w+)*\s*\(.*\)\s+(?:const\s+)?\{", code) 
    modified_code = code
    for definition in function_defs:
        function_name_match = re.search(r"(\w+(?:\s*::\s*\w+)*)\s*\(", definition)
        if function_name_match:
            function_name = function_name_match.group(1)
            insertion_str = f"  LOG(ERROR) << \"{function_name}()\";\n" 
            modified_code = modified_code.replace(definition, definition.replace('{', '{\n' + insertion_str, 1))

    return modified_code

if __name__ == "__main__":
    # Argument parsing for input file
    parser = argparse.ArgumentParser(description='Add logging lines to C++ source code.')
    parser.add_argument('input_file', type=str, help='The C++ source file to modify.')
    args = parser.parse_args()

    # File processing with the specified input file
    for line in fileinput.input(args.input_file, inplace=True):
        print(add_logging(line), end='')
