
-- What is the average ret_from_t0 for each day_offset?
SELECT
    day_offset,
    AVG(ret_from_t0) AS Average_return_from_earnings_date
FROM event_window_long
GROUP BY day_offset
ORDER BY day_offset;

--Which earnings event had the biggest total move across the window?
SELECT 
    earnings_date,
    ret_m3_to_p3,
    (ABS(ret_m3_to_p3)) 
AS ABSOLUTE_MOVE 
FROM event_window  
ORDER BY ABS(ret_m3_to_p3) DESC 
LIMIT 1;

-- Which earnings event had the smallest absolute move across the window?
SELECT
    earnings_date,
    ret_m3_to_p3,
    ABS(ret_m3_to_p3)
AS ABSOLUTE_MOVE
FROM event_window
ORDER BY ABS(ret_m3_to_p3)
LIMIT 1;

-- What is the average ret_m3_to_p3 across all earnings events?
SELECT 
    ROUND(AVG(ret_m3_to_p3)::numeric , 6) AS average_ret_m3_to_p3
FROM event_window;
-- So across your four earnings events, Apple had an average negative move over the full event window.

-- What is the average ret_m3_to_p3 for EPS beats vs misses?
SELECT
    CASE 
        WHEN eps_actual > eps_estimated THEN 'Beat'
        WHEN eps_actual < eps_estimated THEN 'Miss'
        ELSE 'Meet'
    END AS Beat_Miss_Or_Meet,
    ROUND(AVG(ret_m3_to_p3)::numeric , 6) AS average_ret_m3_to_p3
    FROM event_window
GROUP BY
    CASE
        WHEN eps_actual > eps_estimated THEN 'Beat'
        WHEN eps_actual < eps_estimated THEN 'Miss'
        ELSE 'Meet'
    END;

-- What is the average ret_m3_to_p3 for Revenue beats vs misses?

SELECT 
    CASE
        WHEN revenue_actual > revenue_estimated THEN 'Beat'
        WHEN revenue_actual < revenue_estimated THEN 'Miss'
    ELSE 'Meet'
    END AS revenue_type,
    COUNT(*)
    FROM event_window
    GROUP BY
    CASE
        WHEN revenue_actual > revenue_estimated THEN 'Beat'
        WHEN revenue_actual < revenue_estimated THEN 'Miss'
        ELSE 'Meet'
    END;
-- Event level summary table
SELECT
    earnings_date,
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
    ROUND(ret_m3_to_p3 :: numeric,6) AS ret_m3_to_p3
FROM event_window
ORDER BY earnings_date;

-- average return before earnings vs after earnings using event_window_long

SELECT 
    CASE 
        WHEN day_offset < 0 THEN 'Before_Earnings'
        WHEN day_offset > 0 THEN 'After_Earnings'
        ELSE 'Event_day'
    END AS Relative_day,
    AVG(ret_from_t0) AS average_ret_from_t0
    FROM event_window_long
    GROUP BY 
    CASE 
        WHEN day_offset < 0 THEN 'Before_Earnings'
        WHEN day_offset > 0 THEN 'After_Earnings'
        ELSE 'Event_day'
        END;

-- biggest positive return

SELECT
    earnings_date,
    ROUND(ret_m3_to_p3 :: numeric, 6) AS Biggest_Positive_Return
FROM event_window
ORDER BY Biggest_Positive_Return DESC
LIMIT 1;

-- biggest negative return

SELECT
    earnings_date,
    ROUND(ret_m3_to_p3 :: numeric, 6) AS Biggest_Negative_Return
FROM event_window
ORDER BY Biggest_Negative_Return 
LIMIT 1;
