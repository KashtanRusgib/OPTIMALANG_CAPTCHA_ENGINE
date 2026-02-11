import urllib.request
import json
import os

def build_vocabulary():
    print("--- Initializing OPTIMALANG Vocabulary Build V3 ---")
    os.makedirs('vocabulary', exist_ok=True)
    
    # 1. Fetch Thing Explainer 1,000 Word List
    print("[1/3] Fetching Thing Explainer words...")
    te_url = "https://raw.githubusercontent.com/Clarify/upgoer5-words/master/words.txt"
    with urllib.request.urlopen(te_url) as response:
        with open('vocabulary/thing_explainer_1000.txt', 'wb') as f:
            f.write(response.read())

    # 2. Fetch ASD-STE100 Data
    print("[2/3] Fetching and Parsing ASD-STE100 dictionary data...")
    # This source is a more stable JSON representation of STE rules
    ste_url = "https://raw.githubusercontent.com/dblandin/ste-linter/master/lib/ste-linter/dictionary.json"
    
    try:
        with urllib.request.urlopen(ste_url) as response:
            data = json.loads(response.read().decode())
            
            # Extract Approved words (Keys)
            approved_words = [word.upper() for word in data.keys()]
            
            # Extract Unapproved/Banned words (Values within the 'unapproved' arrays)
            banned_words = []
            for entry in data.values():
                if isinstance(entry, dict) and 'unapproved' in entry:
                    banned_words.extend([b.upper() for b in entry['unapproved']])
            
            # Save Approved
            with open('vocabulary/ste_approved_900.txt', 'w') as f:
                f.write("\n".join(sorted(list(set(approved_words)))))
                
            # Save Banned
            with open('vocabulary/ste_banned_1200.txt', 'w') as f:
                f.write("\n".join(sorted(list(set(banned_words)))))
                
        print("--- Build Complete ---")
        print(f"Verified: {len(approved_words)} approved words, {len(banned_words)} banned words.")
        
    except Exception as e:
        print(f"CRITICAL ERROR: {str(e)}")

if __name__ == "__main__":
    build_vocabulary()
