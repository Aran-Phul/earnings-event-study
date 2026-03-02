# Earnings Event Study

Event-study style analysis of stock price reaction around quarterly earnings dates using the Financial Modeling Prep (FMP) API.

## Goals
- Pull daily EOD price data from FMP
- Pull earnings dates for recent quarters
- Measure returns in windows around earnings (e.g. -3 to +3 trading days)
- Visualize and summarize the impact

## Setup
1. Create a virtual environment:
   - `python -m venv .venv`
2. Activate it (Git Bash):
   - `source .venv/Scripts/activate`
3. Install dependencies:
   - `pip install -r requirements.txt`
4. Create `.env` from `.env.example` and add your API key.

## Current progress
- Completed: Project scaffolding + gitignore
- Work in Progress: First API pull script (`fetch_prices.py`)

## Data source
- Financial Modeling Prep API