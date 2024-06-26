USE ORDERS_DIMENSIONAL_DB;

DROP TABLE IF EXISTS {db}.{schema}.DimCategories_SCD1;

CREATE TABLE {db}.{schema}.DimCategories_SCD1
(
    CategoryID_SK_PK INT PRIMARY KEY IDENTITY(1, 1),
    CategoryID_NK INT NOT NULL,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimCustomers_SCD2;

CREATE TABLE {db}.{schema}.DimCustomers_SCD2
(
    CustomerID_SK_PK INT PRIMARY KEY IDENTITY(1, 1),
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
    ValidFrom DATE NULL,
    ValidTo DATE NULL,
    IsCurrent BIT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.FactOrders;

CREATE TABLE {db}.{schema}.FactOrders
(
    OrderID_SK_PK INT PRIMARY KEY IDENTITY(1, 1),
    OrderID_NK INT NOT NULL,
    CustomerID_SK_FK NVARCHAR(10) NOT NULL,
    EmployeeID_SK_FK INT NOT NULL,
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
    TerritoryID_SK_FK NVARCHAR(10) NOT NULL,
    -- From OrderDetails
    ProductID_SK_FK INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(10, 2) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimRegion_SCD3;

CREATE TABLE {db}.{schema}.DimRegion_SCD3
(
    RegionID_SK_PK INT PRIMARY KEY IDENTITY(1, 1),
    RegionID_NK INT NOT NULL,
    RegionDescription NVARCHAR(100) NOT NULL,
    RegionDescription_Prev1 NVARCHAR(100) NULL,
    RegionDescription_Prev1_ValidTo DATE NULL,
    RegionDescription_Prev2 NVARCHAR(100) NULL,
    RegionDescription_Prev2_ValidTo DATE NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimShippers_SCD1;

CREATE TABLE {db}.{schema}.DimShippers_SCD1
(
    ShipperID_SK_PK INT PRIMARY KEY IDENTITY(1, 1),
    ShipperID_NK INT NOT NULL,
    CompanyName NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimTerritories_SCD3;

CREATE TABLE {db}.{schema}.DimTerritories_SCD3
(
    TerritoryID_SK_PK INT PRIMARY KEY IDENTITY(1, 1),
    TerritoryID_NK NVARCHAR(10) NOT NULL,
    TerritoryDescription NVARCHAR(255) NOT NULL,
    TerritoryDescription_Prev1 NVARCHAR(255) NULL,
    TerritoryDescription_Prev1_ValidTo DATE NULL,
    TerritoryDescription_Prev2 NVARCHAR(100) NULL,
    TerritoryDescription_Prev2_ValidTo DATE NULL,
    RegionID_NK_FK INT NOT NULL,
    RegionID_NK_FK_Prev1 INT NULL,
    RegionID_NK_FK_Prev1_ValidTo DATE NULL,
    RegionID_NK_FK_Prev2 INT NULL,
    RegionID_NK_FK_Prev2_ValidTo DATE NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimSuppliers_SCD1;

CREATE TABLE {db}.{schema}.DimSuppliers_SCD1
(
    SupplierID_SK_PK INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
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
    ValidFrom DATE NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimSuppliers_SCD4_History;

CREATE TABLE {db}.{schema}.DimSuppliers_SCD4_History
(
    History_ID INT IDENTITY(1, 1),
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
    ValidFrom DATE NULL,
    ValidTo DATE NULL,
    MergeAction VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimProducts_SCD1;

CREATE TABLE {db}.{schema}.DimProducts_SCD1
(
    ProductID_SK_PK INT IDENTITY(1, 1) NOT NULL,
    ProductID_NK INT NOT NULL,
    ProductName NVARCHAR(255) NULL,
    SupplierID NVARCHAR(50) NULL,
    CategoryID INT NOT NULL,
    QuantityPerUnit NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitsInStock INT NOT NULL,
    UnitsOnOrder INT NOT NULL,
    ReorderLevel INT NOT NULL,
    Discontinued BIT NOT NULL,
    ValidFrom DATE NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimProducts_SCD4_History;

CREATE TABLE {db}.{schema}.DimProducts_SCD4_History
(
    HistoryID INT IDENTITY(1, 1) NOT NULL,
    ProductID_NK INT NOT NULL,
    ProductName NVARCHAR(255) NOT NULL,
    SupplierID NVARCHAR(50) NOT NULL,
    CategoryID INT NOT NULL,
    QuantityPerUnit NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitsInStock INT NOT NULL,
    UnitsOnOrder INT NOT NULL,
    ReorderLevel INT NOT NULL,
    Discontinued BIT NOT NULL,
    ValidFrom DATE NULL,
    ValidTo DATE NULL,
    MergeAction VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimEmployees_SCD1;

CREATE TABLE {db}.{schema}.DimEmployees_SCD1
(
    EmployeeID_SK_PK INT IDENTITY(1, 1) NOT NULL,
    EmployeeID_NK INT NULL,
    LastName NVARCHAR(255) NULL,
    FirstName NVARCHAR(255) NULL,
    Title NVARCHAR(255) NULL,
    TitleOfCourtesy NVARCHAR(50) NULL,
    BirthDate DATE NULL,
    HireDate DATE NULL,
    Address NVARCHAR(50) NULL,
    City NVARCHAR(255) NULL,
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NULL,
    HomePhone NVARCHAR(50) NULL,
    Extension INT NULL,
    Notes NVARCHAR(MAX) NULL,
    ReportsTo INT NULL,
    PhotoPath NVARCHAR(255) NULL,
    ValidFrom DATE NULL
);

DROP TABLE IF EXISTS {db}.{schema}.DimEmployees_SCD4_History;

CREATE TABLE {db}.{schema}.DimEmployees_SCD4_History
(
    History_id INT IDENTITY(1, 1) NOT NULL,
    EmployeeID_NK INT NULL,
    LastName NVARCHAR(255) NULL,
    FirstName NVARCHAR(255) NULL,
    Title NVARCHAR(255) NULL,
    TitleOfCourtesy NVARCHAR(50) NULL,
    BirthDate DATE NULL,
    HireDate DATE NULL,
    Address NVARCHAR(50) NULL,
    City NVARCHAR(255) NULL,
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NULL,
    HomePhone NVARCHAR(50) NULL,
    Extension INT NULL,
    Notes NVARCHAR(MAX) NULL,
    ReportsTo INT NULL,
    PhotoPath NVARCHAR(255) NULL,
    ValidFrom DATE NULL,
    ValidTo DATE NULL,
    MergeAction VARCHAR(10) NOT NULL
);