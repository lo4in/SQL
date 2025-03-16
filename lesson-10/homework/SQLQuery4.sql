WITH AllDays AS (
    -- Generate a sequence of 40 days (assuming a table with at least 40 consecutive numbers exists)
    SELECT ROW_NUMBER() OVER () AS DayNumber
    FROM generate_series(1,40)  -- PostgreSQL; For MySQL/MSSQL, use a Numbers table
),
ShipmentsWithZeros AS (
    -- Left join recorded shipments with the complete 40-day period, filling missing days with 0
    SELECT 
        a.DayNumber, 
        COALESCE(s.Num, 0) AS Num
    FROM AllDays a
    LEFT JOIN Shipments s ON a.DayNumber = s.N
),
Ranked AS (
    -- Rank rows to find the middle values
    SELECT 
        Num, 
        ROW_NUMBER() OVER (ORDER BY Num) AS RowNum,
        COUNT(*) OVER () AS TotalCount
    FROM ShipmentsWithZeros
)
-- Find the median
SELECT AVG(Num) AS Median
FROM Ranked
WHERE RowNum IN (TotalCount / 2, TotalCount / 2 + 1);
s