import pandas as pd
from pathlib import Path

prices_path = Path("data/processed/aapl_prices.csv")
events_path = Path("data/processed/aapl_event_window.csv")

prices = pd.read_csv(prices_path, parse_dates=['date'])
prices['date'] = pd.to_datetime(prices['date'])
prices = prices.sort_values("date").reset_index(drop=True)
print(prices)

events = pd.read_csv(events_path, parse_dates=["earnings_date","trading_date"] )
print(events)

WINDOW = 3

date_to_idx = {d: i for i , d in enumerate (prices["date"]) }
#print(date_to_idx)

rows = []

for _, ev in events.iterrows():
    t0 = ev["trading_date"]

    if t0 not in date_to_idx:
        continue
    idx0 = date_to_idx[t0]

    if idx0 - WINDOW < 0 or idx0 + WINDOW >= len(prices):
        continue
    
    close_t0 = prices.loc[idx0, "close"]

    for k in range(-WINDOW, WINDOW + 1):
        p = prices.loc[idx0 + k]

        rows.append(
            {
                "symbol": ev["symbol"],
                "earnings_date": ev["earnings_date"],
                "trading_date": t0,
                "day_offset": k,
                "window_date": p["date"],
                "close": p["close"],
                "ret_from_t0": (p["close"] / close_t0) - 1,
                # optional: include event-window return on every row (handy for filtering)
                "ret_m3_to_p3": ev.get("ret_m3_to_p3"),
            }
        )

long_df = pd.DataFrame(rows).sort_values(["earnings_date", "day_offset"]).reset_index(drop=True)

out_path = Path("data/processed/aapl_event_window_long.csv")
out_path.parent.mkdir(parents=True, exist_ok=True)
long_df.to_csv(out_path, index=False)

print("Saved:", out_path)
print(long_df.head(10))


