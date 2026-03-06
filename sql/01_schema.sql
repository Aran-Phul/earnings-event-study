-- sql/01_schema.sql

CREATE TABLE IF NOT EXISTS prices_daily (
  symbol TEXT NOT NULL,
  date DATE NOT NULL,
  open NUMERIC,
  high NUMERIC,
  low NUMERIC,
  close NUMERIC,
  volume BIGINT,
  vwap NUMERIC,
  change NUMERIC,
  change_percent NUMERIC,
  PRIMARY KEY (symbol, date)
);

CREATE TABLE IF NOT EXISTS earnings (
  symbol TEXT NOT NULL,
  earnings_date DATE NOT NULL,
  eps_actual NUMERIC,
  eps_estimated NUMERIC,
  revenue_actual NUMERIC,
  revenue_estimated NUMERIC,
  last_updated DATE,
  PRIMARY KEY (symbol, earnings_date)
);

CREATE TABLE IF NOT EXISTS event_window (
  symbol TEXT NOT NULL,
  earnings_date DATE NOT NULL,
  trading_date DATE,
  eps_actual NUMERIC,
  eps_estimated NUMERIC,
  revenue_actual NUMERIC,
  revenue_estimated NUMERIC,
  last_updated DATE,
  close NUMERIC,
  close_m3 NUMERIC,
  close_p3 NUMERIC,
  ret_m3_to_p3 NUMERIC,
  PRIMARY KEY (symbol, earnings_date)
);

CREATE TABLE IF NOT EXISTS event_window_long (
  symbol TEXT NOT NULL,
  earnings_date DATE NOT NULL,
  trading_date DATE NOT NULL,
  day_offset INT NOT NULL,
  window_date DATE NOT NULL,
  close NUMERIC,
  ret_from_t0 NUMERIC,
  ret_m3_to_p3 NUMERIC
);