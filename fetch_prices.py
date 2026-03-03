
#TODO 1: imports
# - load_dotenv from dotenv
from dotenv import load_dotenv 
# - os
import os
# - requests
import requests

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
print(params)

# TODO: make request (include a timeout)
r = requests.get(url, params=params, timeout=30)

# TODO: print status code
if r.status_code != 200:
    print(r.text)

# TODO: raise if bad response (so you see errors clearly)
r.raise_for_status()

# TODO: parse JSON and print the “shape”
data = r.json()
print(type(data))

# HINT: if it's a dict, print the keys:
if isinstance(data, dict)
print(data.keys())


