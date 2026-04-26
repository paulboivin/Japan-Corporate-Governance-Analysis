-- Query 5: GDP Growth and Investment Relationship
-- Purpose: Validates the regression model finding that capex growth
-- in year T predicts GDP growth in year T+1
-- Business Question 5: What is the historical relationship between
-- investment and economic output that underpins the forecast?

SELECT
    m1.Calendar_Year,
    ROUND(m1.Capex_Trillion_Yen, 2) AS Capex_T_Yen,
    -- Capex YoY growth rate (year T)
    ROUND((m1.Capex_Trillion_Yen - 
           m0.Capex_Trillion_Yen) * 100.0 /
           m0.Capex_Trillion_Yen, 2) AS Capex_Growth_Pct,
    -- GDP growth rate in following year (year T+1)
    ROUND((m2.GDP_Constant_2015_USD - 
           m1.GDP_Constant_2015_USD) * 100.0 /
           m1.GDP_Constant_2015_USD, 2) AS Next_Year_GDP_Growth_Pct,
    -- Classify whether investment growth preceded GDP growth
    CASE
        WHEN (m1.Capex_Trillion_Yen - m0.Capex_Trillion_Yen) > 0
         AND (m2.GDP_Constant_2015_USD - 
              m1.GDP_Constant_2015_USD) > 0
        THEN 'Both positive'
        WHEN (m1.Capex_Trillion_Yen - m0.Capex_Trillion_Yen) > 0
         AND (m2.GDP_Constant_2015_USD - 
              m1.GDP_Constant_2015_USD) <= 0
        THEN 'Capex up, GDP down'
        WHEN (m1.Capex_Trillion_Yen - m0.Capex_Trillion_Yen) <= 0
         AND (m2.GDP_Constant_2015_USD - 
              m1.GDP_Constant_2015_USD) > 0
        THEN 'Capex down, GDP up'
        ELSE 'Both negative'
    END AS Direction_Relationship
FROM japan_master m1
LEFT JOIN japan_master m0 
    ON m0.Calendar_Year = m1.Calendar_Year - 1
LEFT JOIN japan_master m2 
    ON m2.Calendar_Year = m1.Calendar_Year + 1
WHERE m0.Calendar_Year IS NOT NULL
  AND m2.Calendar_Year IS NOT NULL
ORDER BY m1.Calendar_Year;