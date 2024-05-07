-- Primary Key Constraints
ALTER TABLE Categories ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);
ALTER TABLE Customers ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);
ALTER TABLE Employees ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);
ALTER TABLE OrderDetails ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID);
ALTER TABLE Orders ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);
ALTER TABLE Products ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID);
ALTER TABLE Region ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);
ALTER TABLE Shippers ADD CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID);
ALTER TABLE Suppliers ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);
ALTER TABLE Territories ADD CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID);

-- Foreign Key Constraints
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES Employees (EmployeeID);
ALTER TABLE OrderDetails ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);
ALTER TABLE OrderDetails ADD CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products (ProductID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers (ShipperID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories (TerritoryID);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID);
ALTER TABLE Territories ADD CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID) REFERENCES Region (RegionID);