
#TODO 1: imports
# - load_dotenv from dotenv
from dotenv import load_dotenv 
# - os
import os
# - requests
import requests
import pandas as pd

print(load_dotenv())
api_key = os.getenv("FMP_API_KEY")
if not api_key:
    raise SystemError("Missing FMP_API_KEY. Check your .env file is in this folder and named exactly '.env'.")

print("KEY FOUND" if api_key else "KEY MISSING")
#print(api_key)

base_url = "https://financialmodelingprep.com/stable"
endpoint = "/historical-price-eod/full"
symbol = "AAPL"

# TODO: build full URL (base_url + endpoint)
url = f"{base_url}{endpoint}"
print(url)

# TODO: build params dict with symbol + apikey
params = {"symbol": symbol, "apikey": api_key}


# TODO: make request (include a timeout)
r = requests.get(url, params=params, timeout=30)

# TODO: print status code
if r.status_code != 200:
    print(r.text)

# TODO: raise if bad response (so you see errors clearly)
r.raise_for_status()

# TODO: parse JSON and print the “shape”
data = r.json()
print("len:", len(data))
print("first item type:", type(data[0]))
print("first item keys:", data[0].keys() if isinstance(data[0], dict) else "not a dict")
print("first item:", data[0])
print(type(data))

df = pd.DataFrame(data)
cols = ["symbol","date","open","high","low","close","volume","vwap","change","changePercent"]
df["date"] = pd.to_datetime(df["date"])
df = df.sort_values("date", ascending=False).reset_index(drop=True)
df.to_csv("data/processed/aapl_prices.csv", index=False)
# HINT: if it's a dict, print the keys:
if isinstance(data, dict):
    print(data.keys())


