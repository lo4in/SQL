-- Step 1: Create a temporary table
CREATE TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary INT
);

-- Step 2: Insert updated records with department rotation
INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT 
    EmployeeID, 
    Name, 
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department -- Keep unchanged if unexpected value appears
    END AS Department,
    Salary
FROM Employees;

-- Step 3: Retrieve the updated records
SELECT * FROM #EmployeeTransfers;

-- (Optional) Drop the temporary table when done
DROP TABLE #EmployeeTransfers;
