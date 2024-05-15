USE ORDERS_RELATIONAL_DB;

DROP TABLE IF EXISTS {db}.{schema}.Categories;

CREATE TABLE {db}.{schema}.Categories (
    CategoryID INT NOT NULL,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Customers;

CREATE TABLE {db}.{schema}.Customers (
    CustomerID NVARCHAR(10) NOT NULL,
    CompanyName NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255) NOT NULL,
    ContactTitle NVARCHAR(255) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(255) NOT NULL,
    Region NVARCHAR(255) NULL,
    PostalCode NVARCHAR(20) NULL,
    Country NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(50) NOT NULL,
    Fax NVARCHAR(50) NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Employees;

CREATE TABLE {db}.{schema}.Employees (
    EmployeeID INT NOT NULL,
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

DROP TABLE IF EXISTS {db}.{schema}.OrderDetails;

CREATE TABLE {db}.{schema}.OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(10, 2) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Orders;

CREATE TABLE {db}.{schema}.Orders (
    OrderID INT NOT NULL,
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
    TerritoryID NVARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Products;

CREATE TABLE {db}.{schema}.Products (
    ProductID INT NOT NULL,
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

DROP TABLE IF EXISTS {db}.{schema}.Region;

CREATE TABLE {db}.{schema}.Region (
    RegionID INT NOT NULL,
    RegionDescription NVARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Shippers;

CREATE TABLE {db}.{schema}.Shippers (
    ShipperID INT NOT NULL,
    CompanyName NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Territories;

CREATE TABLE {db}.{schema}.Territories (
    TerritoryID NVARCHAR(10) NOT NULL,
    TerritoryDescription NVARCHAR(255) NOT NULL,
    RegionID INT NOT NULL
);

DROP TABLE IF EXISTS {db}.{schema}.Suppliers;

CREATE TABLE {db}.{schema}.Suppliers (
    SupplierID INT NOT NULL,
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
    HomePage NVARCHAR(255) NULL
);
