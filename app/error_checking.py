from collections import Counter

def check_duplicate_values(list_of_dicts, key):
    values = [d[key] for d in list_of_dicts if key in d]
    value_counts = Counter(values)
    return any(count > 1 for count in value_counts.values())

def string_exists_or_ends_with(target_string, string_array):
    for s in string_array:
        if target_string.lower() == s.lower() or target_string.lower().endswith(s.lower()):
            return True
    return False