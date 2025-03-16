WITH Grouped AS (
    SELECT 
        StepNumber,
        Status,
        StepNumber - SUM(CASE WHEN Status = LAG(Status) OVER (ORDER BY StepNumber) 
                              THEN 0 ELSE 1 END) 
                    OVER (ORDER BY StepNumber) AS GroupID
    FROM Groupings
)
SELECT 
    MIN(StepNumber) AS MinStepNumber,
    MAX(StepNumber) AS MaxStepNumber,
    Status,
    COUNT(*) AS ConsecutiveCount
FROM Grouped
GROUP BY GroupID, Status
ORDER BY MinStepNumber;
