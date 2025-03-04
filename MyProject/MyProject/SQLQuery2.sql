

WITH TopSalaries AS (
    SELECT *, 
           PERCENT_RANK() OVER (ORDER BY Salary DESC) AS PercentRank
    FROM Employees
)
SELECT Department, 
       AVG(Salary) AS AverageSalary,
       CASE 
           WHEN Salary > 80000 THEN 'High'
           WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM TopSalaries
WHERE PercentRank <= 0.10
GROUP BY Department, SalaryCategory
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;
