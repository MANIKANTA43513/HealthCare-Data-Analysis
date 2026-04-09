"""
PlatinumRx Assignment | Python Proficiency
File: 02_Remove_Duplicates.py
Task: Given a string, remove all duplicate characters using a loop
      and print the unique string (preserving first-occurrence order).
"""


def remove_duplicates(input_string: str) -> str:
    """
    Remove duplicate characters from a string using a loop.
    Preserves the order of first occurrence.
    """
    result = ""                          # start with an empty string
    for char in input_string:            # iterate over every character
        if char not in result:           # check: already added?
            result += char               # if not, append it
        # if already present, skip (duplicate)
    return result


# ── Test cases ────────────────────────────────────────────────
test_strings = [
    "programming",
    "hello world",
    "aabbccdd",
    "PlatinumRx",
    "mississippi",
    "abcdefg",    # no duplicates
    "",           # edge case: empty string
    "aaaa",       # edge case: all same
    "Data Analyst",
]

print("=" * 50)
print("  Remove Duplicate Characters (loop-based)")
print("=" * 50)
for s in test_strings:
    print(f"  Input  : {repr(s)}")
    print(f"  Output : {repr(remove_duplicates(s))}")
    print()
print("=" * 50)

# ── Interactive mode ──────────────────────────────────────────
if __name__ == "__main__":
    print("\nEnter a string (or 'q' to quit):")
    while True:
        user_input = input("  String: ")
        if user_input.lower() == "q":
            break
        print(f"  → {remove_duplicates(user_input)}\n")
