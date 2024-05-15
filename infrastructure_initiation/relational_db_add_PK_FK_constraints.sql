-- Primary Key Constraints
ALTER TABLE {db}.{scheme}.Categories ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);
ALTER TABLE {db}.{scheme}.Customers ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);
ALTER TABLE {db}.{scheme}.Employees ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);
ALTER TABLE {db}.{scheme}.OrderDetails ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID);
ALTER TABLE {db}.{scheme}.Orders ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);
ALTER TABLE {db}.{scheme}.Products ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID);
ALTER TABLE {db}.{scheme}.Region ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);
ALTER TABLE {db}.{scheme}.Shippers ADD CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID);
ALTER TABLE {db}.{scheme}.Suppliers ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);
ALTER TABLE {db}.{scheme}.Territories ADD CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID);

-- Foreign Key Constraints
ALTER TABLE {db}.{scheme}.Employees ADD CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES Employees (EmployeeID);
ALTER TABLE {db}.{scheme}.OrderDetails ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);
ALTER TABLE {db}.{scheme}.OrderDetails ADD CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products (ProductID);
ALTER TABLE {db}.{scheme}.Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);
ALTER TABLE {db}.{scheme}.Orders ADD CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID);
ALTER TABLE {db}.{scheme}.Orders ADD CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers (ShipperID);
ALTER TABLE {db}.{scheme}.Orders ADD CONSTRAINT FK_Orders_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories (TerritoryID);
ALTER TABLE {db}.{scheme}.Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID);
ALTER TABLE {db}.{scheme}.Products ADD CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID);
ALTER TABLE {db}.{scheme}.Territories ADD CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID) REFERENCES Region (RegionID);