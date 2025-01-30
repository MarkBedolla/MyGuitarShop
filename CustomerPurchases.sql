USE MyGuitarShop
--1.
/*
SELECT CustomerID,
Line1 + ', ' + City + ', ' + [State] + ' ' + Zipcode AS CustomerAddress
From Addresses
*/

/*
SELECT FirstName + ' ' + LastName AS "Name", Addresses.CustomerID, 
Line1 + ', ' + City + ', ' + [State] + ' ' + Zipcode AS CustomerAddress
From Addresses JOIN Customers
ON Addresses.CustomerID = Customers.CustomerID
*/ 

--2.
/*
SELECT *
FROM Products
Where ProductName LIKE 'G%' OR ProductName LIKE 'F%' 
ORDER BY ProductName;
*/

/*SELECT COUNT(*) AS NumberOfProducts, CategoryID
FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) > 2
*/

/*
SELECT Distinct Left(ProductName, Charindex(' ', ProductName)) As CompanyName
FROM Products
*/

/*
SELECT Distinct Left(ProductName, Charindex(' ', ProductName)) As CompanyName,
COUNT(ProductID) AS #Products
FROM Products
GROUP BY Left(ProductName, Charindex(' ', ProductName))
Having COUNT(ProductID)>1
*/

--3.

/*SELECT CardType, COUNT(OrderID) AS #Order
FROM Orders
GROUP BY CardType
ORDER BY COUNT(CardType)
DESC;
*/

/*SELECT MONTH(OrderDate) as "Month", COUNT(Orders.OrderID) as #Orders,
SUM(ItemPrice * Quantity) as #OrderTotal
FROM Orders INNER JOIN OrderItems
ON Orders.OrderID=OrderItems.OrderID
GROUP BY MONTH(OrderDate); */

--4.
SELECT LastName, Customers.CustomerID,
COUNT(Distinct Categories.CategoryID) AS NumCategories
FROM Customers JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderItems 
ON Orders.OrderID = OrderItems.OrderID
JOIN Products
ON OrderItems.ProductID = Products.ProductID
JOIN Categories 
ON Products.CategoryID = Categories.CategoryID
GROUP BY LastName, Customers.CustomerID
Having COUNT(Distinct Categories.CategoryID) > 1


/*SELECT CategoryName, COUNT(Distinct OrderItems.ProductID) AS #UniqueProductID
FROM Categories JOIN Products 
ON Categories.CategoryID = Products.CategoryID
JOIN OrderItems
ON Products.ProductID = OrderItems.ProductID
GROUP BY CategoryName
*/

/*SELECT Left(EmailAddress, Charindex('@', EmailAddress)-1) AS Email,
COUNT(OrderID) AS Orders
FROM Customers
JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Left(EmailAddress, Charindex('@', EmailAddress)-1)
Having COUNT(OrderID) = 0
*/
