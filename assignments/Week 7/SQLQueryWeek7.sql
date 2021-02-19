--Query 1

SELECT ProductCode,
		ProductName,
		ListPrice,
		DiscountPercent 
FROM Products
ORDER BY ListPrice DESC

--Query 2

SELECT LastName+', '+FirstName as CustomerFullName
FROM Customers
WHERE LastName like '[M-Z]%' 
ORDER BY LastName ASC

--Query 3

SELECT ProductName, ListPrice, DateAdded
FROM Products
WHERE ListPrice >500 and ListPrice < 2000 
ORDER BY DateAdded DESC

--Query 4

SELECT ProductName, ListPrice,
		DiscountPercent,
		(DiscountPercent*ListPrice*0.01) AS DiscountAmount,
		ListPrice - (DiscountPercent*ListPrice*0.01)  AS DiscountPrice
FROM Products
ORDER BY DiscountPrice DESC

--Query 5 ( Work with nulls and test expressions??)

SELECT ItemID, ItemPrice, DiscountAmount, Quantity,
		ItemPrice*Quantity AS PriceTotal,
		DiscountAmount*Quantity AS DiscountTotal,
		(ItemPrice - DiscountAmount)* Quantity AS ItemTotal
FROM OrderItems
WHERE ((ItemPrice - DiscountAmount)* Quantity) > 500 
ORDER BY ItemTotal DESC

--Query 6

SELECT OrderID, OrderDate, ShipDate
FROM Orders
WHERE ShipDate is NULL

--Query 7
DECLARE @price float = 100.0
DECLARE @tax_rate float = 0.07

SELECT @price AS Price,
		@tax_rate AS Tax_Rate,
		 tax_Amount = @price * @tax_rate,
		Total_Price = (@price * @tax_rate) + @price
 

 --Query 8

 SELECT CategoryName, ProductName, ListPrice FROM Categories
 JOIN Products
 ON Categories.CategoryID = Products.CategoryID
 ORDER BY CategoryName, Productname

 --Query 9 ()

 SELECT FirstName, LastName, Line1, City, State, ZipCode 
 FROM Customers
 JOIN Addresses
 ON Customers.CustomerID = Addresses.CustomerID
 WHERE Customers.EmailAddress = 'allan.sherwood@yahoo.com'

 --Query 10 (Return one row for each customer, but only return addresses that are the shipping address for a customer.)


SELECT FirstName, LastName,
Line1, City, State, ZipCode
FROM Customers JOIN Addresses ON
Customers.CustomerID = Addresses.CustomerID
AND
Customers.ShippingAddressID = Addresses.AddressID


 --Query 11

 SELECT LastName as ln, FirstName, OrderDate as od, ProductName as pn, ItemPrice, DiscountAmount, Quantity 
 FROM Customers
 JOIN Orders
 ON Customers.CustomerID = Orders.CustomerID
 JOIN OrderItems
 ON Orders.OrderID = OrderItems.OrderID
 JOIN Products
 ON Products.ProductID = OrderItems.ProductID
 ORDER BY ln, od, pn

 --Query 12




 SELECT p1.ProductName, p2.ListPrice
 FROM Products p1
 INNER JOIN Products p2 
 ON p1.ListPrice = p2.ListPrice
 WHERE p1.ListPrice = p2.ListPrice
 GROUP BY p1.ProductName,p2.ListPrice HAVING COUNT(p2.ListPrice) > 1

 select ListPrice from Products

 
 SELECT ProductName,
 (SELECT ListPrice
 FROM Products
 GROUP BY ListPrice
 HAVING COUNT(ListPrice) > 1) as ListPrice
 FROM Products
 WHERE ListPrice =  (select ListPrice
 FROM Products
 GROUP BY ListPrice
 HAVING COUNT(ListPrice) > 1)
 
 
--on Products.ListPrice = Products.ListPrice

-- Query 13

select * from Categories

SELECT CategoryName, ProductID FROM Categories
FULL JOIN Products
ON Products.CategoryID = Categories.CategoryID
WHERE ProductID IS NULL
