USE ORDERS_DIMENSIONAL_DB;

CREATE TABLE DimCategories_SCD1 (
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

CREATE TABLE DimRegion_SCD3 (
    RegionID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    RegionID_NK INT NOT NULL,
    RegionDescription NVARCHAR(100) NOT NULL
    RegionDescription_Prev1 NVARCHAR(100) NULL,
    RegionDescription_Prev1_ValidTo INT NULL,
    RegionDescription_Prev2 NVARCHAR(100) NULL,
    RegionDescription_Prev2_ValidTo INT NULL
);

CREATE TABLE DimShippers_SCD1 (
	ShipperID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    ShipperID_NK INT NOT NULL,
	CompanyName NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NOT NULL
);

CREATE TABLE DimTerritories_SCD3 (
    TerritoryID_SK_PK INT PRIMARY KEY IDENTITY(1,1),
    TerritoryID_NK NVARCHAR(10) NOT NULL,
    TerritoryDescription NVARCHAR(255) NOT NULL,
    TerritoryDescription_Prev1 NVARCHAR(255) NULL,
    TerritoryDescription_Prev1_ValidTo INT NULL,
    TerritoryDescription_Prev2 NVARCHAR(100) NULL,
    TerritoryDescription_Prev2_ValidTo NVARCHAR(255) NULL,
    RegionID_NK_FK INT NOT NULL,
    RegionID_NK_FK_Prev1 INT NOT NULL,
    RegionID_NK_FK_Prev1_ValidTo INT NULL,
    RegionID_NK_FK_Prev2 INT NOT NULL,
    RegionID_NK_FK_Prev2_ValidTo INT NULL
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
	ValidFrom INT NULL
);

DROP TABLE IF EXISTS DimSuppliers_SCD4_History;
GO

CREATE TABLE DimSuppliers_SCD4_History
(
	History_ID INT IDENTITY(1,1),
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
	ValidFrom INT NULL,
	ValidTo INT NULL
);

CREATE TABLE DimProducts_SCD1(
 [ProductID_SK_PK] [int] IDENTITY(1,1) NOT NULL,
 [ProductID_NK] [int] NOT NULL,
 [ProductName] [nvarchar](255) NULL,
 [SupplierID] [varchar](50) NULL,
 [CategoryID] [int]NOT NULL,
 [QuantityPerUnit] [nvarchar](100) NOT NULL,
 [UnitPrice] [decimal](10,2) NOT NULL,
 [UnitsInStock] [int] NOT NULL,
 [UnitsOnOrder] [int] NOT NULL,
 [ReorderLevel] [int] NOT NULL,
 [Discontinued] [bit] NOT NULL,
 [ValidFrom] [datetime] NULL
) ;

CREATE TABLE DimProducts_SCD4_History
(
 [HistoryID] [int] IDENTITY(1,1) NOT NULL,
 [ProductID_NK] [int] NOT NULL,
 [ProductName] [nvarchar](255) NOT NULL,
 [SupplierID] [varchar](50) NOT NULL,
 [CategoryID] [int] NOT NULL,
 [QuantityPerUnit] [nvarchar](100) NOT NULL,
 [UnitPrice] [decimal](10,2) NOT NULL,
 [UnitsInStock] [int] NOT NULL,
 [UnitsOnOrder] [int] NOT NULL,
 [ReorderLevel] [int] NOT NULL,
 [Discontinued] [bit] NOT NULL,
 [ValidFrom] [datetime] NULL,
 [ValidTo] [datetime] NULL
);


CREATE TABLE DimEmployees_SCD1(
 [EmployeeID_SK_PK] [int] IDENTITY(1,1) NOT NULL,
 [EmployeeID_NK] [int] NULL,
 [LastName] [nvarchar](255) NULL,
 [FirstName] [nvarchar](255) NULL,
 [Title] [nvarchar](255) NULL,
 [TitleOfCourtesy] [nvarchar](50) NULL,
 [BirthDate] [datetime] NULL,
 [HireDate] [datetime] NULL,
 [Address] [nvarchar](50) NULL,
 [City] [nvarchar](255) NULL,
 [Region] [nvarchar](255) NULL,
 [PostalCode] [nvarchar](20) NULL,
 [Country] [nvarchar](100) NULL,
 [HomePhone] [nvarchar](50) NULL,
 [Extension] [int] NULL,
 [Notes] [nvarchar](MAX) NULL,
 [ReportsTo] [int] NULL,
 [PhotoPath] [nvarchar](255) NULL,
 [ValidFrom] [datetime] NULL	
);


CREATE TABLE DimEmployees_SCD4_History
(
 [history_id] [int] IDENTITY(1,1) NOT NULL,
 [EmployeeID_NK] [int] NULL,
 [LastName] [nvarchar](255) NULL,
 [FirstName] [nvarchar](255) NULL,
 [Title] [nvarchar](255) NULL,
 [TitleOfCourtesy] [nvarchar](50) NULL,
 [BirthDate] [datetime] NULL,
 [HireDate] [datetime] NULL,
 [Address] [nvarchar](50) NULL,
 [City] [nvarchar](255) NULL,
 [Region] [nvarchar](255) NULL,
 [PostalCode] [nvarchar](20) NULL,
 [Country] [nvarchar](100) NULL,
 [HomePhone] [nvarchar](50) NULL,
 [Extension] [int] NULL,
 [Notes] [nvarchar](MAX) NULL,
 [ReportsTo] [int] NULL,
 [PhotoPath] [nvarchar](255) NULL,
 [ValidFrom] [datetime] NULL,
 [ValidTo] [datetime] NULL
) 
