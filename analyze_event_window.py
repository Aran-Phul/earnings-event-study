import pandas as pd
from pathlib import Path

prices_path = Path("data/processed/aapl_prices.csv")
earnings_path = Path("data/processed/aapl_earnings.csv")

prices = pd.read_csv(prices_path, parse_dates=['date'])
prices = prices.sort_values("date").reset_index(drop=True)

prices["close_m3"] = prices["close"].shift(3)
prices["close_p3"] = prices["close"].shift(-3)

prices["ret_1d"] = prices["close"].pct_change()

print(prices[["date","close","close_m3","close_p3"]].tail(8))



earnings = pd.read_csv(earnings_path, parse_dates=["date"])
earnings = earnings.rename(columns={"date": "earnings_date"})
earnings = earnings.sort_values("earnings_date").reset_index(drop=True)
earnings = earnings[earnings["epsActual"].notna()].copy()

events = pd.merge_asof(
    earnings,
    prices[["date","close","close_m3","close_p3"]].sort_values("date"),
    left_on="earnings_date",
    right_on="date",
    direction="forward"

).rename(columns={"date" : "trading_date"})

events["ret_m3_to_p3"] = (events["close_p3"] / events["close_m3"]) - 1
events = events.dropna(subset=["trading_date", "close_m3", "close_p3"]).copy()

events = events.sort_values("earnings_date", ascending=False).head(4)
print(events)

events.to_csv("data/processed/aapl_event_window.csv", index=False)
print("Saved: data/processed/aapl_event_window.csv")