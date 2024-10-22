from collections import Counter

from fastapi import HTTPException

def check_duplicate_values(list_of_dicts, key):
    values = [d[key] for d in list_of_dicts if key in d]
    value_counts = Counter(values)
    return any(count > 1 for count in value_counts.values())

def string_exists_or_ends_with(target_string, string_array):
    for s in string_array:
        if target_string.lower() == s.lower() or target_string.lower().endswith(s.lower()):
            return True
    return False

def handle_exception(e, knownErrorStrings):
    #If exception does not have status_code or detail properties, return default uninformative error message
    if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
        raise HTTPException(status_code=400, detail="Invalid Request")
    
    #If exception detail is known, return the error details, else return default uninformative error message
    if string_exists_or_ends_with(e.detail, knownErrorStrings):
        raise HTTPException(status_code=e.status_code, detail=e.detail)
    else:
        raise HTTPException(status_code=400, detail= "Invalid Request")