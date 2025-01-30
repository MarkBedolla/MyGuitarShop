USE [MyGuitarShop]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[Line1] [varchar](60) NOT NULL,
	[Line2] [varchar](60) NULL,
	[City] [varchar](40) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZipCode] [varchar](10) NOT NULL,
	[Phone] [varchar](12) NOT NULL,
	[Disabled] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[Password] [varchar](60) NOT NULL,
	[FirstName] [varchar](60) NOT NULL,
	[LastName] [varchar](60) NOT NULL,
	[ShippingAddressID] [int] NULL,
	[BillingAddressID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerAddresses]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CustomerAddresses] as
select customer.CustomerID, EmailAddress, LastName, FirstName, 
billing.Line1 as [Billing Address 1], 
billing.Line2 as [Billing Address 2], 
billing.City as [Billing City], 
billing.State as [Billing State], 
billing.ZipCode as [Billing Zip], 
shipping.Line1 as [Shipping Address 1], 
shipping.Line2 as [Shipping Address 2], 
shipping.City as [Shipping City], 
shipping.State as [Shipping State], 
shipping.ZipCode as[Shipping Zip]
from Customers customer, Addresses shipping, Addresses billing
where customer.BillingAddressID = billing.AddressID 
and customer.ShippingAddressID = shipping.AddressID
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[ItemPrice] [money] NOT NULL,
	[DiscountAmount] [money] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderDate] [datetime] NOT NULL,
	[ShipAmount] [money] NOT NULL,
	[TaxAmount] [money] NOT NULL,
	[ShipDate] [datetime] NULL,
	[ShipAddressID] [int] NOT NULL,
	[CardType] [varchar](50) NOT NULL,
	[CardNumber] [char](16) NOT NULL,
	[CardExpires] [char](7) NOT NULL,
	[BillingAddressID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[ProductName] [varchar](255) NOT NULL,
	[Description] [text] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[DiscountPercent] [money] NOT NULL,
	[DateAdded] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderItemProducts]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrderItemProducts] AS
SELECT Orders.OrderID, OrderDate, TaxAmount, ShipDate,
ItemPrice, DiscountAmount, ItemPrice - DiscountAmount AS DiscountItemPrice, Quantity, ItemPrice * Quantity AS ItemTotal,
CategoryName,
ProductName
FROM Orders JOIN OrderItems
ON Orders.OrderID = OrderItems.OrderID
JOIN Products
ON OrderItems.ProductID = Products.ProductID
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GO
/****** Object:  Table [dbo].[Administrators]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrators](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriesCopy]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriesCopy](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomersCopy]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomersCopy](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[Password] [varchar](60) NOT NULL,
	[FirstName] [varchar](60) NOT NULL,
	[LastName] [varchar](60) NOT NULL,
	[ShippingAddressID] [int] NULL,
	[BillingAddressID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductsCopy]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsCopy](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[ProductName] [varchar](255) NOT NULL,
	[Description] [text] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[DiscountPercent] [money] NOT NULL,
	[DateAdded] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses] ADD  DEFAULT (NULL) FOR [Line2]
GO
ALTER TABLE [dbo].[Addresses] ADD  DEFAULT ((0)) FOR [Disabled]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (NULL) FOR [ShippingAddressID]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (NULL) FOR [BillingAddressID]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (NULL) FOR [ShipDate]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0.00)) FOR [DiscountPercent]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (NULL) FOR [DateAdded]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
/****** Object:  StoredProcedure [dbo].[findAverageSales]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[findAverageSales] AS

DECLARE @count int;
DECLARE @total money;
DECLARE @avg money;

SET @count = (select count(Quantity) from OrderItems)
SET @total = (select sum(ItemPrice - DiscountAmount) * count(Quantity) from OrderItems)
SET @avg = (select (@total / @count))
PRINT '$' + convert(varchar, @avg) + ' is the average sales'
RETURN @avg
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCategory]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--6.

CREATE PROCEDURE [dbo].[spDeleteCategory]
@CategoryName VARCHAR(50)
AS
BEGIN

IF EXISTS 
(SELECT * FROM Categories 
WHERE 
CategoryName = @CategoryName)

BEGIN

DELETE FROM Categories WHERE CategoryName = @categoryName
PRINT 'The delete was successful.'
END
ELSE

BEGIN
PRINT 'The deleted failed.'

END
END

EXEC spDeleteCategory 'Drums'

EXEC spDeleteCategory 'Keyboards'
GO
/****** Object:  StoredProcedure [dbo].[spInsertProduct]    Script Date: 1/30/2025 1:15:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertProduct] 
@CategoryID int, 
@ProductCode varchar(50),
@ProductName varchar(50),
@ListPrice smallmoney,
@DiscountPercent smallmoney
AS

BEGIN

IF @ListPrice < 0
THROW 50001, 'ListPrice does not accept negative numbers',1;
END

BEGIN
IF @DiscountPercent < 0
THROW 50002, 'DiscountPercent does not accept negative numbers',1;
END
BEGIN
INSERT INTO Products
(CategoryID, 
ProductCode, 
ProductName, 
DiscountPercent, 
ListPrice)

VALUES(@CategoryID, 
@ProductCode, 
@ProductName, 
@DiscountPercent, 
@ListPrice)
END

GO
