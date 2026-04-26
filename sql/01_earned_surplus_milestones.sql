-- Query 1: Earned Surplus Growth Over Time
-- Purpose: Tracks Japan's corporate cash accumulation relative to
-- governance reform milestones
-- Business Question 1: How have Japanese corporate cash holdings
-- changed over time relative to governance reform milestones?

SELECT
    Calendar_Year,
    ROUND(Earned_Surplus_Trillion_Yen, 2) AS Earned_Surplus_T_Yen,
    -- Year-over-year change in surplus using LAG window function
    ROUND(Earned_Surplus_Trillion_Yen - 
          LAG(Earned_Surplus_Trillion_Yen) 
          OVER (ORDER BY Calendar_Year), 2) AS YoY_Change_T_Yen,
    -- Percentage change year over year
    ROUND((Earned_Surplus_Trillion_Yen - 
           LAG(Earned_Surplus_Trillion_Yen) 
           OVER (ORDER BY Calendar_Year)) * 100.0 /
           LAG(Earned_Surplus_Trillion_Yen) 
           OVER (ORDER BY Calendar_Year), 2) AS YoY_Change_Pct,
    -- Flag governance reform milestone years
    CASE Calendar_Year
        WHEN 2013 THEN 'Abenomics'
        WHEN 2015 THEN 'Governance Code'
        WHEN 2018 THEN 'Code Revision 1'
        WHEN 2021 THEN 'Code Revision 2'
        WHEN 2023 THEN 'TSE Push'
        ELSE '-'
    END AS Milestone
FROM japan_master
WHERE Earned_Surplus_Trillion_Yen IS NOT NULL
ORDER BY Calendar_Year;