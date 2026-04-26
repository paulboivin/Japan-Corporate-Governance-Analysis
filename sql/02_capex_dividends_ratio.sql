-- Query 2: Capital Deployment Balance Over Time
-- Purpose: Tracks the ratio of shareholder returns to investment
-- showing the shift in corporate capital allocation behavior
-- Business Question 2: Has capital been deployed into investment
-- or returned to shareholders post-2023?

SELECT
    Calendar_Year,
    ROUND(Capex_Trillion_Yen, 2) AS Capex_T_Yen,
    ROUND(Dividends_Trillion_Yen, 2) AS Dividends_T_Yen,
    -- Dividends as percentage of capex
    ROUND(Dividends_Trillion_Yen * 100.0 / 
          Capex_Trillion_Yen, 2) AS Dividends_Pct_of_Capex,
    -- Year-over-year capex growth
    ROUND((Capex_Trillion_Yen - 
           LAG(Capex_Trillion_Yen) 
           OVER (ORDER BY Calendar_Year)) * 100.0 /
           LAG(Capex_Trillion_Yen) 
           OVER (ORDER BY Calendar_Year), 2) AS Capex_YoY_Growth_Pct,
    -- Year-over-year dividend growth
    ROUND((Dividends_Trillion_Yen - 
           LAG(Dividends_Trillion_Yen) 
           OVER (ORDER BY Calendar_Year)) * 100.0 /
           LAG(Dividends_Trillion_Yen) 
           OVER (ORDER BY Calendar_Year), 2) AS Dividends_YoY_Growth_Pct,
    -- Flag reform era
    CASE 
        WHEN Calendar_Year < 2013 THEN 'Pre-reform'
        WHEN Calendar_Year >= 2013 THEN 'Reform era'
    END AS Era
FROM japan_master
ORDER BY Calendar_Year;