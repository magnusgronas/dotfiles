#!/usr/bin/env python3
import sys
import re

# Regex to match lines in the format: 
# [keyword] [R_int] [G_int] [B_int] [optional A_float]
# 
# Group 1: keyword (e.g., background_color)
# Group 2, 3, 4: R, G, B integer components (0-255)
# Group 5: A float (optional, e.g., '0.1' or '1.0')
COLOR_LINE_PATTERN = re.compile(
    r'^(\w+)\s+'           # 1. Keyword (e.g., background_color)
    r'(\d+)\s+'            # 2. Red component (int)
    r'(\d+)\s+'            # 3. Green component (int)
    r'(\d+)'               # 4. Blue component (int)
    r'(?:\s+([\d.]+))?$'   # 5. Optional Alpha component (float/number)
)

def convert_line_to_float(line: str) -> str:
    """
    Parses a line containing a keyword followed by 3 or 4 color values,
    converts the first three (RGB, 0-255) to 0.0-1.0 floats, and 
    returns the reconstructed line.

    If the line doesn't match the expected pattern, it is returned unchanged.
    """
    # Use match to check from the start of the cleaned line
    match = COLOR_LINE_PATTERN.match(line.strip())
    
    if not match:
        # Return the original line stripped of trailing whitespace if no match
        return line.rstrip()

    # Extract captured groups
    keyword = match.group(1)
    r_int = int(match.group(2))
    g_int = int(match.group(3))
    b_int = int(match.group(4))
    a_str = match.group(5) # Alpha is kept as a string/float if present (e.g., '0.1')

    # Convert 0-255 integers to 0.0-1.0 floats
    R_float = r_int / 255.0
    G_float = g_int / 255.0
    B_float = b_int / 255.0
    
    # Format the floats to 6 decimal places for precision
    r_str = f"{R_float:.6f}"
    g_str = f"{G_float:.6f}"
    b_str = f"{B_float:.6f}"

    if a_str:
        # If alpha was present, use the converted RGB floats and the original alpha string
        return f"{keyword} {r_str} {g_str} {b_str} {a_str}"
    else:
        # If no alpha, use the converted RGB floats
        return f"{keyword} {r_str} {g_str} {b_str}"

def main():
    """
    Reads all lines from standard input, converts color lines, and prints the results.
    """
    if sys.stdin.isatty():
        # Only print usage notes if running interactively
        sys.stderr.write("# NOTE: Reading from standard input (Ctrl+D to finish).\n")
        sys.stderr.write("# Only lines matching the pattern '[word] [int] [int] [int] [float/number (optional)]' are converted.\n")
        sys.stderr.write("# Output:\n")
        
    for line in sys.stdin:
        converted_line = convert_line_to_float(line)
        print(converted_line)

if __name__ == "__main__":
    main()

