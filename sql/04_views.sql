CREATE OR REPLACE VIEW vw_event_summary AS
SELECT
    earnings_date,
    trading_date,
    CASE
        WHEN eps_actual > eps_estimated THEN 'Beat'
        WHEN eps_actual < eps_estimated THEN 'Miss'
        ELSE 'Meet'
    END AS eps_result,
    CASE
        WHEN revenue_actual > revenue_estimated THEN 'Beat'
        WHEN revenue_actual < revenue_estimated THEN 'Miss'
        ELSE 'Meet'
    END AS revenue_result,
    close,
    close_m3,
    close_p3,
    ROUND(ret_m3_to_p3::numeric, 6) AS ret_m3_to_p3
FROM event_window
ORDER BY earnings_date;

CREATE OR REPLACE VIEW vw_event_path AS
SELECT
    earnings_date,
    trading_date,
    day_offset,
    window_date,
    close,
    ROUND(ret_from_t0::numeric, 6) AS ret_from_t0,
    ROUND(ret_m3_to_p3::numeric, 6) AS ret_m3_to_p3
FROM event_window_long
ORDER BY earnings_date, day_offset;