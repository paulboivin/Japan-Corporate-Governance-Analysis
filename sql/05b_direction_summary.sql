-- Summary count of direction relationships
SELECT
    Direction_Relationship,
    COUNT(*) AS Year_Count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS Pct_of_Total
FROM (
    SELECT
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
)
GROUP BY Direction_Relationship
ORDER BY Year_Count DESC;