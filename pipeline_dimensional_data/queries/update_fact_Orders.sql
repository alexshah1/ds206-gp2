MERGE INTO {dst_db}.{dst_schema}.FactOrders AS DST
USING (
    SELECT     
        o.OrderID,
        o.CustomerID,
        o.EmployeeID,
        o.OrderDate,
        o.RequiredDate,
        o.ShippedDate,
        o.ShipVia,
        o.Freight,
        o.ShipName,
        o.ShipAddress,
        o.ShipCity,
        o.ShipRegion,
        o.ShipPostalCode,
        o.ShipCountry,
        o.TerritoryID,
        od.ProductID,
        od.UnitPrice,
        od.Quantity,
        od.Discount
    FROM [ORDERS_RELATIONAL_DB].[dbo].[Orders] o 
    JOIN [ORDERS_RELATIONAL_DB].[dbo].[OrderDetails] od ON o.OrderID = od.OrderID 
) AS SRC
ON DST.OrderID_NK = SRC.OrderID AND DST.ProductID_SK_FK = SRC.ProductID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        OrderID_NK,
        CustomerID_SK_FK,
        EmployeeID_SK_FK,
        OrderDate,
        RequiredDate,
        ShippedDate,
        ShipVia,
        Freight,
        ShipName,
        ShipAddress,
        ShipCity,
        ShipRegion,
        ShipPostalCode,
        ShipCountry,
        TerritoryID_SK_FK,
        ProductID_SK_FK,
        UnitPrice,
        Quantity,
        Discount
    ) VALUES (
        SRC.OrderID,
        SRC.CustomerID,
        SRC.EmployeeID,
        SRC.OrderDate,
        SRC.RequiredDate,
        SRC.ShippedDate,
        SRC.ShipVia,
        SRC.Freight,
        SRC.ShipName,
        SRC.ShipAddress,
        SRC.ShipCity,
        SRC.ShipRegion,
        SRC.ShipPostalCode,
        SRC.ShipCountry,
        SRC.TerritoryID,
        SRC.ProductID,
        SRC.UnitPrice,
        SRC.Quantity,
        SRC.Discount
    )
WHEN MATCHED THEN
    UPDATE SET
        DST.CustomerID_SK_FK = SRC.CustomerID,
        DST.EmployeeID_SK_FK = SRC.EmployeeID,
        DST.OrderDate = SRC.OrderDate,
        DST.RequiredDate = SRC.RequiredDate,
        DST.ShippedDate = SRC.ShippedDate,
        DST.ShipVia = SRC.ShipVia,
        DST.Freight = SRC.Freight,
        DST.ShipName = SRC.ShipName,
        DST.ShipAddress = SRC.ShipAddress,
        DST.ShipCity = SRC.ShipCity,
        DST.ShipRegion = SRC.ShipRegion,
        DST.ShipPostalCode = SRC.ShipPostalCode,
        DST.ShipCountry = SRC.ShipCountry,
        DST.TerritoryID_SK_FK = SRC.TerritoryID,
        DST.UnitPrice = SRC.UnitPrice,
        DST.Quantity = SRC.Quantity,
        DST.Discount = SRC.Discount;