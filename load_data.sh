#! /usr/bin/bash
export PGPASSWORD='Enter_Password_Here'
set -e

PSQL="psql --username=postgres --dbname=earnings_event_study"
$PSQL -c "TRUNCATE TABLE earnings, event_window, event_window_long, prices_daily RESTART IDENTITY CASCADE;"

echo "Creating tables from schema..."
$PSQL -f sql/01_schema.sql

echo "Loading earnings..."
$PSQL -c "\copy earnings(symbol, earnings_date, eps_actual, eps_estimated, revenue_actual, revenue_estimated, last_updated) FROM 'data/processed/aapl_earnings.csv' WITH (FORMAT csv, HEADER true)"

echo "Loading prices..."
$PSQL -c "\copy prices_daily(symbol, date, open, high, low, close, volume, vwap, change, change_percent) FROM 'data/processed/aapl_prices.csv' WITH (FORMAT csv, HEADER true)"

echo "Loading event window..."
$PSQL -c "\copy event_window(symbol, earnings_date, eps_actual, eps_estimated, revenue_actual, revenue_estimated, last_updated, trading_date, close, close_m3, close_p3, ret_m3_to_p3) FROM 'data/processed/aapl_event_window.csv' WITH (FORMAT csv, HEADER true)"

echo "Loading event window long..."
$PSQL -c "\copy event_window_long(symbol, earnings_date, trading_date, day_offset, window_date, close, ret_from_t0, ret_m3_to_p3) FROM 'data/processed/aapl_event_window_long.csv' WITH (FORMAT csv, HEADER true)"

echo "Checking row counts..."
$PSQL -c "SELECT COUNT(*) AS prices_count FROM prices_daily;"
$PSQL -c "SELECT COUNT(*) AS earnings_count FROM earnings;"
$PSQL -c "SELECT COUNT(*) AS event_window_count FROM event_window;"
$PSQL -c "SELECT COUNT(*) AS event_window_long_count FROM event_window_long;"

echo "Load complete."

unset PGPASSWORD