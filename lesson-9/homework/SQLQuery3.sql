WITH RECURSIVE EmployeeHierarchy AS (
    -- Базовый случай: Президент на глубине 0
    SELECT 
        EmployeeID, 
        ManagerID, 
        JobTitle, 
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Рекурсивный случай: каждый подчинённый имеет глубину на 1 больше, чем его менеджер
    SELECT 
        e.EmployeeID, 
        e.ManagerID, 
        e.JobTitle, 
        eh.Depth + 1 AS Depth
    FROM Employees e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy ORDER BY Depth, EmployeeID;
