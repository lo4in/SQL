use class1

--create table Employees1(
--	EmployeeID INT,
--	Name vARCHAR(50),
--	Department VARCHAR(50),
--	Salary DECIMAL(10,2),
--	HireDate DATE
--)

SELECT EmployeeID, Name, Department, Salary, 
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

WITH RankedEmployees AS (
    SELECT EmployeeID, Name, Salary, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT * 
FROM RankedEmployees
WHERE SalaryRank IN (
    SELECT SalaryRank FROM RankedEmployees
    GROUP BY SalaryRank HAVING COUNT(*) > 1
);

SELECT EmployeeID, Name, Department, Salary, 
       DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptSalaryRank
FROM Employees
WHERE DeptSalaryRank <= 2;

SELECT EmployeeID, Name, Department, Salary
FROM (
    SELECT EmployeeID, Name, Department, Salary, 
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees
) AS Ranked
WHERE SalaryRank = 1;

SELECT EmployeeID, Name, Department, Salary, 
       SUM(Salary) OVER (PARTITION BY Department ORDER BY Salary ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Employees;
