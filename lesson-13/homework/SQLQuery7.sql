DECLARE @Year INT = 2024;  -- Set the desired year
DECLARE @Month INT = 3;    -- Set the desired month (e.g., March)

WITH Calendar AS (
    -- Generate a sequence of days for the given month
    SELECT 
        DATEADD(DAY, n - 1, DATEFROMPARTS(@Year, @Month, 1)) AS CalendarDate
    FROM 
        (SELECT TOP (31) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n FROM master.dbo.spt_values) AS Numbers
    WHERE 
        MONTH(DATEADD(DAY, n - 1, DATEFROMPARTS(@Year, @Month, 1))) = @Month
),
Formatted AS (
    -- Add WeekNumber and Weekday Name
    SELECT 
        CalendarDate,
        DATEPART(WEEKDAY, CalendarDate) AS WeekDayNumber,
        DATENAME(WEEKDAY, CalendarDate) AS WeekDayName,
        DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1 AS WeekNum
    FROM Calendar
)
-- Pivot the data to arrange days in week format (Sunday to Saturday)
SELECT 
    WeekNum,
    MAX(CASE WHEN WeekDayNumber = 1 THEN CalendarDate END) AS Sunday,
    MAX(CASE WHEN WeekDayNumber = 2 THEN CalendarDate END) AS Monday,
    MAX(CASE WHEN WeekDayNumber = 3 THEN CalendarDate END) AS Tuesday,
    MAX(CASE WHEN WeekDayNumber = 4 THEN CalendarDate END) AS Wednesday,
    MAX(CASE WHEN WeekDayNumber = 5 THEN CalendarDate END) AS Thursday,
    MAX(CASE WHEN WeekDayNumber = 6 THEN CalendarDate END) AS Friday,
    MAX(CASE WHEN WeekDayNumber = 7 THEN CalendarDate END) AS Saturday
FROM Formatted
GROUP BY WeekNum
ORDER BY WeekNum;
