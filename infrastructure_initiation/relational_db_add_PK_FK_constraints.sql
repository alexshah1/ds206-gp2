-- Primary Key Constraints
ALTER TABLE {db}.{schema}.Categories ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);
ALTER TABLE {db}.{schema}.Customers ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);
ALTER TABLE {db}.{schema}.Employees ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);
ALTER TABLE {db}.{schema}.OrderDetails ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID);
ALTER TABLE {db}.{schema}.Orders ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);
ALTER TABLE {db}.{schema}.Products ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID);
ALTER TABLE {db}.{schema}.Region ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);
ALTER TABLE {db}.{schema}.Shippers ADD CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID);
ALTER TABLE {db}.{schema}.Suppliers ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);
ALTER TABLE {db}.{schema}.Territories ADD CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID);

-- Foreign Key Constraints
ALTER TABLE {db}.{schema}.Employees ADD CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES Employees (EmployeeID);
ALTER TABLE {db}.{schema}.OrderDetails ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);
ALTER TABLE {db}.{schema}.OrderDetails ADD CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products (ProductID);
ALTER TABLE {db}.{schema}.Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);
ALTER TABLE {db}.{schema}.Orders ADD CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID);
ALTER TABLE {db}.{schema}.Orders ADD CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers (ShipperID);
ALTER TABLE {db}.{schema}.Orders ADD CONSTRAINT FK_Orders_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories (TerritoryID);
ALTER TABLE {db}.{schema}.Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID);
ALTER TABLE {db}.{schema}.Products ADD CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID);
ALTER TABLE {db}.{schema}.Territories ADD CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID) REFERENCES Region (RegionID);