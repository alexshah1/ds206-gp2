USE ORDERS_DIMENSIONAL_DB;

CREATE TABLE DimCategories (
    CategoryID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    CategoryID_NK INT NOT NULL,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL
);

CREATE TABLE DimCustomers_SCD2 ( -- Do we need _SCD2 in the name?
    CustomerID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    CustomerID_NK NVARCHAR(10) NOT NULL,
    CompanyName NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255) NOT NULL,
    ContactTitle NVARCHAR(255) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(255) NOT NULL,
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(50) NOT NULL,
    Fax NVARCHAR(50) NULL,
	ValidFrom INT NULL,
 	ValidTo INT NULL,
 	IsCurrent BIT NULL
);

CREATE TABLE DimEmployees (
    EmployeeID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID_NK INT NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    FirstName NVARCHAR(255) NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    TitleOfCourtesy NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(255) NOT NULL,
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    HomePhone NVARCHAR(50) NOT NULL,
    Extension INT NOT NULL,
    Notes NVARCHAR(MAX) NOT NULL,
    ReportsTo INT NULL,
    PhotoPath NVARCHAR(255) NOT NULL
);

CREATE TABLE FactOrders (
    OrderID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    OrderID_NK INT NOT NULL,
    CustomerID NVARCHAR(10) NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    RequiredDate DATE NOT NULL,
    ShippedDate DATE NULL,
    ShipVia INT NOT NULL,
    Freight DECIMAL(10, 2) NOT NULL,
    ShipName NVARCHAR(255) NOT NULL,
    ShipAddress NVARCHAR(255) NOT NULL,
    ShipCity NVARCHAR(50) NOT NULL,
    ShipRegion NVARCHAR(50) NULL,
    ShipPostalCode NVARCHAR(10) NULL,
    ShipCountry NVARCHAR(50) NOT NULL,
    TerritoryID NVARCHAR(10) NOT NULL,
    -- From OrderDetails
    ProductID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE DimProducts (
    ProductID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    ProductID_NK INT NOT NULL,
    ProductName NVARCHAR(255) NOT NULL,
    SupplierID INT NOT NULL,
    CategoryID INT NOT NULL,
    QuantityPerUnit NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitsInStock INT NOT NULL,
    UnitsOnOrder INT NOT NULL,
    ReorderLevel INT NOT NULL,
    Discontinued BIT NOT NULL
);

CREATE TABLE DimRegion_SCD3 (
    RegionID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    RegionID_NK INT NOT NULL,
    RegionDescription NVARCHAR(100) NOT NULL
);

CREATE TABLE DimShippers (
    ShipperID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    ShipperID_NK INT NOT NULL,
    CompanyName NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NOT NULL
);

CREATE TABLE DimTerritories (
    TerritoryID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    TerritoryID_NK NVARCHAR(10) NOT NULL,
    TerritoryDescription NVARCHAR(255) NOT NULL,
    RegionID INT NOT NULL
);

DROP TABLE IF EXISTS DimSuppliers_SCD1;
GO

CREATE TABLE DimSuppliers_SCD1 (
    SupplierID_SK_PK INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    SupplierID_NK INT NOT NULL,
    CompanyName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100) NOT NULL,
    ContactTitle NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Region NVARCHAR(100) NULL,
    PostalCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Fax NVARCHAR(20) NULL,
    HomePage NVARCHAR(255) NULL,
	ValidFrom DATETIME NULL
);

DROP TABLE IF EXISTS DimSuppliers_SCD4_History;
GO

CREATE TABLE DimSuppliers_SCD4_History
(
	History_id INT IDENTITY(1,1),
	SupplierID_NK INT NOT NULL,
    CompanyName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100) NOT NULL,
    ContactTitle NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Region NVARCHAR(100) NULL,
    PostalCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Fax NVARCHAR(20) NULL,
    HomePage NVARCHAR(255) NULL,
	ValidFrom DATETIME NULL,
	ValidTo DATETIME NULL
) 
