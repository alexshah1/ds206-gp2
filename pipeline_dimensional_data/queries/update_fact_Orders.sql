MERGE INTO {dst_db}.{dst_schema}.FactOrders AS DST
USING (
    SELECT     
        o.OrderID_NK,
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
    FROM {src_db}.{src_schema}.Orders o 
    JOIN {src_db}.{src_schema}.OrderDetails od
    ON o.OrderID = od.OrderID 
) AS SRC
ON DST.OrderID_NK = SRC.OrderID_NK AND DST.ProductID = SRC.ProductID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        OrderID_NK,
        CustomerID,
        EmployeeID,
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
        TerritoryID,
        ProductID,
        UnitPrice,
        Quantity,
        Discount
    ) VALUES (
        SRC.OrderID_NK,
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
        DST.CustomerID = SRC.CustomerID,
        DST.EmployeeID = SRC.EmployeeID,
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
        DST.TerritoryID = SRC.TerritoryID,
        DST.UnitPrice = SRC.UnitPrice,
        DST.Quantity = SRC.Quantity,
        DST.Discount = SRC.Discount;
