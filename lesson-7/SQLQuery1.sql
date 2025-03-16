SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT 
    c.CustomerID, 
    c.CustomerName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


SELECT 
    o.OrderID, 
    p.ProductName, 
    od.Quantity
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;


SELECT 
    c.CustomerID, 
    c.CustomerName, 
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 1;

SELECT 
    od.OrderID, 
    p.ProductName, 
    od.Price
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.Price = (
    SELECT MAX(Price) 
    FROM OrderDetails 
    WHERE OrderDetails.OrderID = od.OrderID
);
