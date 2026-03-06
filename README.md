# Earnings Event Study (AAPL)

A portfolio data analytics project that measures how Apple’s stock price reacts around quarterly earnings announcements using the Financial Modeling Prep (FMP) API.

This project is being built as an end-to-end pipeline using:

- **Python** for data collection, cleaning, and event-window analysis
- **PostgreSQL / psql** for relational storage and querying
- **Power BI** for dashboarding and visualization

---

## Project Goal

The goal of this project is to identify and quantify market reactions to Apple earnings events by:

- pulling daily stock price data from a live API
- pulling quarterly earnings data from a live API
- aligning earnings dates to trading days
- calculating returns in an earnings event window
- storing the cleaned data in PostgreSQL
- visualizing the results in Power BI

---

## Current Progress

### Completed
- Project setup with virtual environment and GitHub repository
- Connected to the Financial Modeling Prep API
- Pulled and cached **AAPL daily stock price data**
- Pulled and cached **AAPL quarterly earnings data**
- Exported cleaned CSVs for prices and earnings
- Built an **event window dataset** using trading-day offsets
- Built a **long-format event window dataset** for plotting and BI use
- Created and connected to a PostgreSQL database: `earnings_event_study`

### Current datasets
Located in `data/processed/`:

- `aapl_prices.csv`
- `aapl_earnings.csv`
- `aapl_event_window.csv`
- `aapl_event_window_long.csv`

### In progress
- Creating PostgreSQL schema and loading processed datasets into tables
- Preparing SQL views for Power BI

### Planned
- Import processed CSVs into PostgreSQL
- Create SQL views for analysis-ready tables
- Build a Power BI dashboard showing:
  - price movement around earnings
  - event-window returns by quarter
  - summary metrics such as average return and hit rate

---

## Project Structure

```text
earnings-impact/
├─ data/
│  ├─ raw/
│  │  ├─ aapl_prices_raw.json
│  │  └─ aapl_earnings_raw.json
│  └─ processed/
│     ├─ aapl_prices.csv
│     ├─ aapl_earnings.csv
│     ├─ aapl_event_window.csv
│     └─ aapl_event_window_long.csv
├─ sql/
│  └─ 01_schema.sql
├─ analyze_event_window.py
├─ build_event_window_long.py
├─ fetch_prices.py
├─ fetch_earnings.py
├─ README.md
├─ requirements.txt
├─ .env.example
└─ .gitignore