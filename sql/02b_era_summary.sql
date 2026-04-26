-- Query 2b: Average growth rates by era
-- Summarizes the structural shift in capital allocation behavior

SELECT
    CASE
        WHEN Calendar_Year < 2013 THEN 'Pre-reform (2001-2012)'
        ELSE 'Reform era (2013-2024)'
    END AS Era,
    ROUND(AVG(Capex_Trillion_Yen), 2) AS Avg_Capex_T_Yen,
    ROUND(AVG(Dividends_Trillion_Yen), 2) AS Avg_Dividends_T_Yen,
    ROUND(AVG(Dividends_Trillion_Yen * 100.0 /
          Capex_Trillion_Yen), 2) AS Avg_Dividends_Pct_of_Capex,
    -- Count years in each era
    COUNT(*) AS Years_in_Era,
    -- Total capex deployed in era
    ROUND(SUM(Capex_Trillion_Yen), 2) AS Total_Capex_T_Yen,
    -- Total dividends paid in era
    ROUND(SUM(Dividends_Trillion_Yen), 2) AS Total_Dividends_T_Yen
FROM japan_master
GROUP BY Era
ORDER BY Era;