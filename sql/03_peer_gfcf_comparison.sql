-- Query 3: Four-Country GFCF Comparison
-- Purpose: Compares Japan's investment rate to peer economies
-- showing Japan's relative position over time
-- Business Question 3: How does Japan's corporate investment
-- behavior compare to US, Germany, and South Korea?

SELECT
    Calendar_Year,
    ROUND(Japan_GFCF_Pct_GDP, 2) AS Japan_GFCF_Pct,
    ROUND(Korea_GFCF_Pct_GDP, 2) AS Korea_GFCF_Pct,
    ROUND(Germany_GFCF_Pct_GDP, 2) AS Germany_GFCF_Pct,
    ROUND(USA_GFCF_Pct_GDP, 2) AS USA_GFCF_Pct,
    -- Japan's rank among four countries each year
    CASE
        WHEN Japan_GFCF_Pct_GDP >= Korea_GFCF_Pct_GDP
         AND Japan_GFCF_Pct_GDP >= Germany_GFCF_Pct_GDP
         AND Japan_GFCF_Pct_GDP >= USA_GFCF_Pct_GDP THEN 1
        WHEN Japan_GFCF_Pct_GDP <= Korea_GFCF_Pct_GDP
         AND Japan_GFCF_Pct_GDP <= Germany_GFCF_Pct_GDP
         AND Japan_GFCF_Pct_GDP <= USA_GFCF_Pct_GDP THEN 4
        WHEN Japan_GFCF_Pct_GDP >= Germany_GFCF_Pct_GDP
         AND Japan_GFCF_Pct_GDP >= USA_GFCF_Pct_GDP THEN 2
        ELSE 3
    END AS Japan_Rank
FROM peer_comparison
ORDER BY Calendar_Year;