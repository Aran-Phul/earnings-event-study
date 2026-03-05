import pandas as pd
from pathlib import Path

prices_path = Path("data/processed/aapl_prices.csv")
events_path = Path("data/processed/aapl_event_window.csv")

prices = pd.read_csv(prices_path, parse_dates=['date'])
prices['date'] = pd.to_datetime(prices['date'])
prices = prices.sort_values("date", ascending=False).reset_index(drop=True)
print(prices)

events = pd.read_csv(events_path, parse_dates=["earnings_date"] )
print(events)

