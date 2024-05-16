DECLARE @Today DATE = CONVERT(DATE, GETDATE());
DECLARE @Yesterday DATE = CONVERT(DATE, DATEADD(DAY, -1, @Today));

DECLARE @Product_SCD4 TABLE
(
    ProductID_NK INT,
    ProductName NVARCHAR(255),
    SupplierID NVARCHAR(50),
    CategoryID INT,
    QuantityPerUnit NVARCHAR(100),
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT,
    ValidFrom DATE,
    MergeAction NVARCHAR(10)
) 

MERGE {dst_db}.{dst_schema}.DimProducts_SCD1 AS DST
USING {src_db}.{src_schema}.Products AS SRC
ON (SRC.ProductID = DST.ProductID_NK)

WHEN NOT MATCHED THEN
    INSERT (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, ValidFrom)
    VALUES (SRC.ProductID, SRC.ProductName, SRC.SupplierID, SRC.CategoryID, SRC.QuantityPerUnit, SRC.UnitPrice, SRC.UnitsInStock, SRC.UnitsOnOrder, SRC.ReorderLevel, SRC.Discontinued, @Today)

WHEN MATCHED AND (
        ISNULL(DST.ProductID_NK,'') <> ISNULL(SRC.ProductID,'') OR
        ISNULL(DST.ProductName,'') <> ISNULL(SRC.ProductName,'') OR
        ISNULL(DST.SupplierID,'') <> ISNULL(SRC.SupplierID,'') OR
        ISNULL(DST.CategoryID,'') <> ISNULL(SRC.CategoryID,'') OR
        ISNULL(DST.QuantityPerUnit,'') <> ISNULL(SRC.QuantityPerUnit,'') OR
        ISNULL(DST.UnitPrice,'') <> ISNULL(SRC.UnitPrice,'') OR
        ISNULL(DST.UnitsInStock,'') <> ISNULL(SRC.UnitsInStock,'') OR
        ISNULL(DST.UnitsOnOrder,'') <> ISNULL(SRC.UnitsOnOrder,'') OR
        ISNULL(DST.ReorderLevel,'') <> ISNULL(SRC.ReorderLevel,'') OR
        ISNULL(DST.Discontinued,'') <> ISNULL(SRC.Discontinued,'')
    )
THEN 
    UPDATE SET 
        DST.ProductName = SRC.ProductName,
        DST.SupplierID = SRC.SupplierID,
        DST.CategoryID = SRC.CategoryID,
        DST.QuantityPerUnit = SRC.QuantityPerUnit,
        DST.UnitPrice = SRC.UnitPrice,
        DST.UnitsInStock = SRC.UnitsInStock,
        DST.UnitsOnOrder = SRC.UnitsOnOrder,
        DST.ReorderLevel = SRC.ReorderLevel,
        DST.Discontinued = SRC.Discontinued,
        DST.ValidFrom = @Yesterday

OUTPUT 
    DELETED.ProductID_NK, 
    DELETED.ProductName, 
    DELETED.SupplierID, 
    DELETED.CategoryID, 
    DELETED.QuantityPerUnit, 
    DELETED.UnitPrice, 
    DELETED.UnitsInStock, 
    DELETED.UnitsOnOrder, 
    DELETED.ReorderLevel, 
    DELETED.Discontinued, 
    DELETED.ValidFrom, 
    $ACTION AS MergeAction
INTO @Product_SCD4 (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, ValidFrom, MergeAction);

INSERT INTO {dst_db}.{dst_schema}.DimProducts_SCD4_History (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, ValidFrom, ValidTo, MergeAction)
SELECT ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, ValidFrom, @Today, MergeAction
FROM @Product_SCD4
WHERE ProductID_NK IS NOT NULL;
