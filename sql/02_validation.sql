-- Check how many earnings events are in the event summary table
SELECT COUNT(*) AS event_count
FROM event_window;

-- Check the earliest and latest earnings dates in the event summary table
SELECT
    MIN(earnings_date) AS earliest_earnings_date,
    MAX(earnings_date) AS latest_earnings_date
FROM event_window;

-- earliest and latest window_date in event_window_long

SELECT
    MIN(window_date) AS earliest_window_date,
    MAX(window_date) AS latest_window_date
FROM event_window_long;

-- number of rows in event window long

SELECT COUNT(*)
FROM event_window_long;

-- How many rows are there for each day_offset in event_window_long
SELECT 
    day_offset,
    COUNT (*) AS offset_row_count 
FROM event_window_long 
GROUP BY day_offset 
ORDER BY day_offset;


-- confirm each earnings_date in event_window_long has 7 rows.
SELECT
    earnings_date,
    COUNT(*) AS number_of_rows
FROM event_window_long
GROUP BY earnings_date;