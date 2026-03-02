
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
    raise SystemError("...")

print("KEY FOUND" if api_key else "KEY MISSING")
#print(api_key)
print("Hello Proect")


