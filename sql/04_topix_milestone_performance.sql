-- Query 4: TOPIX Performance Around Governance Milestones
-- Purpose: Measures market returns in years surrounding each
-- governance reform milestone
-- Business Question 4: Is there a measurable correlation between
-- reform milestones and stock market performance?

SELECT
    Calendar_Year,
    ROUND(TOPIX_Year_End, 2) AS TOPIX_Year_End,
    -- Year over year TOPIX change
    ROUND(TOPIX_Year_End - 
          LAG(TOPIX_Year_End) 
          OVER (ORDER BY Calendar_Year), 2) AS TOPIX_YoY_Change,
    -- Percentage change
    ROUND((TOPIX_Year_End - 
           LAG(TOPIX_Year_End) 
           OVER (ORDER BY Calendar_Year)) * 100.0 /
           LAG(TOPIX_Year_End) 
           OVER (ORDER BY Calendar_Year), 2) AS TOPIX_YoY_Pct,
    -- Classify each year relative to milestones
    CASE Calendar_Year
        WHEN 2013 THEN 'Milestone — Abenomics'
        WHEN 2014 THEN 'Post-milestone +1'
        WHEN 2015 THEN 'Milestone — Gov Code'
        WHEN 2016 THEN 'Post-milestone +1'
        WHEN 2018 THEN 'Milestone — Code Rev 1'
        WHEN 2019 THEN 'Post-milestone +1'
        WHEN 2021 THEN 'Milestone — Code Rev 2'
        WHEN 2022 THEN 'Post-milestone +1'
        WHEN 2023 THEN 'Milestone — TSE Push'
        WHEN 2024 THEN 'Post-milestone +1'
        ELSE 'Non-milestone year'
    END AS Year_Classification
FROM japan_master
ORDER BY Calendar_Year;