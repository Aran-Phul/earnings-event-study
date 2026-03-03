from dotenv import load_dotenv
import os
import requests
import pandas as pd
import json
from pathlib import Path
load_dotenv()
api_key = os.getenv("FMP_API_KEY")
if not api_key:
    raise SystemError("Missing API KEY. Check your .env file")
print("KEY FOUND" if api_key else "KEY MISSING")

base_url = "https://financialmodelingprep.com/stable"
endpoint = "/earnings"
symbol = "AAPL"

url = f"{base_url}{endpoint}"
params = {"symbol": symbol,"apikey": api_key}

raw_path = Path("data") / "raw" / "aapl_earnings_raw.json"
raw_path.parent.mkdir(parents=True, exist_ok=True)

if raw_path.exists():
    with open(raw_path, "r", encoding="utf-8") as f: data = json.load(f)

else:
    r = requests.get(url, params=params, timeout=30)
    if r.status_code != 200:
        print(r.text)
    r.raise_for_status()
    data = r.json()

    with open(raw_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)

print("len:", len(data))
print("first item type:", type(data[0]))
print("first item keys:", data[0].keys() if isinstance(data[0], dict) else "not a dict")
print("first item:", data[0])
print(type(data))



