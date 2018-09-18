/*	
	Create/Alter/Edit the existing data in the Northwind database
*/


-- 1. List of Managers with all their Workers:

SELECT
  CONCAT(managers.FirstName, ' ', managers.LastName) AS `Managers`, 
  CONCAT(employees.FirstName, ' ', employees.LastName) AS `Workers`
FROM
  employees LEFT JOIN employees AS managers ON employees.ReportsTo = managers.employeeID
ORDER BY
  managers.employeeID;
  
-- -----------------------------------------------------------------------------------------------------
  
-- 2. Lists Managers with number of people working under them

SELECT
  managers.employeeID,
  CONCAT(managers.FirstName, ' ', managers.LastName) AS `Managers`, 
  COUNT(employees.ReportsTo) as Number_of_Workers
FROM
  employees INNER JOIN employees AS managers ON employees.ReportsTo = managers.employeeID
GROUP BY
  managers.employeeID;
  


-- -----------------------------------------------------------------------------------------------------
                                             -- VIEWS: -- 
/* 
> 3. product sales for 1997 (original view)

CREATE VIEW `Product Sales for 1997` AS
SELECT Categories.CategoryName, 
       Products.ProductName, 
       Sum((`OrderDetails`.UnitPrice*Quantity*(1-Discount)/100)*100) AS ProductSales
FROM Categories
 JOIN    Products On Categories.CategoryID = Products.CategoryID
    JOIN  `OrderDetails` on Products.ProductID = `OrderDetails`.ProductID     
     JOIN  `Orders` on Orders.OrderID = `OrderDetails`.OrderID 
WHERE Orders.ShippedDate Between '1997-01-01' And '1997-12-31'
GROUP BY Categories.CategoryName, Products.ProductName;

> Change the view to show only the ProductName and ProductSales, and ORDER BY ProductSales
*/  

CREATE VIEW  `Product Sales for 1997` AS
SELECT  
       Categories.CategoryName,
       Products.ProductName, 
       Sum((`OrderDetails`.UnitPrice*Quantity*(1-Discount)/100)*100) AS ProductSales
FROM Categories
	INNER JOIN Products On Categories.CategoryID = Products.CategoryID
    INNER JOIN  `OrderDetails` on Products.ProductID = `OrderDetails`.ProductID     
	INNER JOIN  `Orders` on Orders.OrderID = `OrderDetails`.OrderID 
WHERE Orders.ShippedDate Between '1997-01-01' And '1997-12-31'
GROUP BY Products.ProductName
ORDER BY ProductSales DESC;

SELECT * FROM `northwind`.`product sales for 1997`;

-- 4. List all purchases made in 1997:

SELECT  
	   Orders.CustomerID,
       Products.ProductName, 
       OrderDetails.UnitPrice*Quantity AS Amount
FROM Products
    INNER JOIN  `OrderDetails` on Products.ProductID = `OrderDetails`.ProductID     
	INNER JOIN  `Orders` on Orders.OrderID = `OrderDetails`.OrderID 
WHERE Orders.ShippedDate Between '1997-01-01' And '1997-12-31' ;

-- -----------------------------------------------------------------------------------------------------

/* 5. Category Sales for 1997 (original view)

CREATE VIEW `Category Sales for 1997` AS
SELECT     `Product Sales for 1997`.CategoryName, 
       Sum(`Product Sales for 1997`.ProductSales) AS CategorySales
FROM `Product Sales for 1997`
GROUP BY `Product Sales for 1997`.CategoryName;

> add ORDER BY CategorySales
*/

CREATE VIEW `Category Sales for 1997` AS
SELECT     `Product Sales for 1997`.CategoryName, 
       Sum(`Product Sales for 1997`.ProductSales) AS CategorySales
FROM `Product Sales for 1997`
GROUP BY `Product Sales for 1997`.CategoryName
ORDER BY CategorySales DESC;

SELECT * FROM `northwind`.`category sales for 1997`;

-- -----------------------------------------------------------------------------------------------------













  
  
  