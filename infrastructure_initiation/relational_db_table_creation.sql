USE ORDERS_RELATIONAL_DB;
GO


CREATE TABLE Categories (
    CategoryID INT,
    CategoryName NVARCHAR(255),
    Description NVARCHAR(MAX)
);
GO


CREATE TABLE Customers (
    CustomerID NVARCHAR(10),
    CompanyName NVARCHAR(255),
    ContactName NVARCHAR(255),
    ContactTitle NVARCHAR(255),
    Address NVARCHAR(255),
    City NVARCHAR(255),
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100),
    Phone NVARCHAR(50),
    Fax NVARCHAR(50) NULL
);
GO

CREATE TABLE Employees (
    EmployeeID INT,
    LastName NVARCHAR(255),
    FirstName NVARCHAR(255),
    Title NVARCHAR(255),
    TitleOfCourtesy NVARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Address NVARCHAR(255),
    City NVARCHAR(255),
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20),
    Country NVARCHAR(100),
    HomePhone NVARCHAR(50),
    Extension NVARCHAR(10),
    Notes NVARCHAR(MAX),
    ReportsTo INT NULL,
    PhotoPath NVARCHAR(255)
);
GO


CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(10, 2)
);
GO


CREATE TABLE Orders (
    OrderID INT,
    CustomerID VARCHAR(10),
    EmployeeID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE NULL,
    ShipVia INT,
    Freight DECIMAL(10, 2),
    ShipName VARCHAR(255),
    ShipAddress VARCHAR(255),
    ShipCity VARCHAR(50),
    ShipRegion VARCHAR(50) NULL,
    ShipPostalCode VARCHAR(10) NULL,
    ShipCountry VARCHAR(50),
    TerritoryID INT
);
GO


CREATE TABLE Products (
    ProductID INT,
    ProductName NVARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit NVARCHAR(100),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT
);
GO


CREATE TABLE Region (
    RegionID INT,
    RegionDescription NVARCHAR(100)
);
GO


CREATE TABLE Shippers (
    ShipperID INT,
    CompanyName NVARCHAR(255),
    Phone NVARCHAR(20)
);
GO


CREATE TABLE Territories (
    TerritoryID NVARCHAR(10),
    TerritoryDescription NVARCHAR(255),
    RegionID INT
);
GO


CREATE TABLE Suppliers (
    ContactTitle NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    Region NVARCHAR(100) NULL,
    PostalCode NVARCHAR(20),
    Country NVARCHAR(100),
    Phone NVARCHAR(20),
    Fax NVARCHAR(20) NULL,
    HomePage NVARCHAR(255) NULL
);
GO