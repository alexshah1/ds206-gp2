INSERT INTO {db}.{schema}.FactOrders(
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
)
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

    From [ORDERS_RELATIONAL_DB].[dbo].[Orders] o 
    JOIN [ORDERS_RELATIONAL_DB].[dbo].[OrderDetails] od
    ON o.OrderID = od.OrderID 
    WHERE o.OrderID NOT IN (
        SELECT fo.OrderID_NK 
        FROM FactOrders fo JOIN Orders o1
        ON o1.OrderID = fo.OrderID_NK)