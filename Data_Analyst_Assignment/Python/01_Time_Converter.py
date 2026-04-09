"""
PlatinumRx Assignment | Python Proficiency
File: 01_Time_Converter.py
Task: Given a number of minutes, convert it into human-readable form.
      130 → "2 hrs 10 minutes"
      110 → "1hr 50minutes"
"""


def convert_minutes(total_minutes: int) -> str:
    """
    Convert total minutes to human-readable form.
    Examples (matching assignment spec):
        130 → "2 hrs 10 minutes"
        110 → "1hr 50minutes"
    """
    if not isinstance(total_minutes, int) or total_minutes < 0:
        raise ValueError("Input must be a non-negative integer.")

    hours          = total_minutes // 60   # integer division
    remaining_mins = total_minutes %  60   # modulo remainder

    if hours == 0:
        return f"{remaining_mins} minutes"
    elif remaining_mins == 0:
        hr_label = "hr" if hours == 1 else "hrs"
        return f"{hours}{hr_label}"
    else:
        # Singular "hr" when exactly 1 hour, plural "hrs" otherwise
        # Space between number and unit only when hours > 1 (matches spec examples)
        if hours == 1:
            return f"{hours}hr {remaining_mins}minutes"
        else:
            return f"{hours} hrs {remaining_mins} minutes"


# ── Test cases ────────────────────────────────────────────────
test_values = [130, 110, 60, 45, 0, 90, 125, 200, 75]

print("=" * 40)
print("  Minutes → Human Readable Converter")
print("=" * 40)
for mins in test_values:
    print(f"  {mins:>4} minutes  →  {convert_minutes(mins)}")
print("=" * 40)

# ── Interactive mode ──────────────────────────────────────────
if __name__ == "__main__":
    print("\nEnter a number of minutes (or 'q' to quit):")
    while True:
        user_input = input("  Minutes: ").strip()
        if user_input.lower() == "q":
            break
        try:
            result = convert_minutes(int(user_input))
            print(f"  → {result}\n")
        except ValueError as e:
            print(f"  Error: {e}\n")
