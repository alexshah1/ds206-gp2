DECLARE  @Product_SCD4 TABLE
(
	[ProductID_NK] [int] NULL,
	[ProductName] [nvarchar](255) NULL,
	[SupplierID] [varchar](50) NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](100) NULL,
	[UnitPrice] [decimal](10,2) NULL,
	[UnitsInStock] [int]  NULL,
	[UnitsOnOrder] [int] NULL,
	[ReorderLevel] [int] NULL,
	[Discontinued] [bit] NULL,
	[ValidFrom] [datetime] NULL,
	[MergeAction] [varchar](10) NULL
) 

-- Merge statement
MERGE		dbo.DimProducts_SCD1			AS DST
USING		dbo.Products				AS SRC
ON			(SRC.ProductID_NK = DST.ProductID_NK)

WHEN NOT MATCHED THEN

INSERT (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,ReorderLevel,Discontinued, ValidFrom)
VALUES (SRC.ProductID_NK, SRC.ProductName, SRC.SupplierID, SRC.CategoryID, SRC.QuantityPerUnit, SRC.UnitPrice, SRC.UnitsInStock, SRC.UnitsOnOrder,SRC.ReorderLevel,SRC.Discontinued,GETDATE())

WHEN MATCHED 
AND		
	 ISNULL(DST.ProductID_NK,'') <> ISNULL(SRC.ProductID_NK,'') 
	 OR ISNULL(DST.ProductName,'') <> ISNULL(SRC.ProductName,'')
	 OR ISNULL(DST.SupplierID,'') <> ISNULL(SRC.SupplierID,'')
	 OR ISNULL(DST.CategoryID,'') <> ISNULL(SRC.CategoryID,'')
	 OR ISNULL(DST.QuantityPerUnit,'') <> ISNULL(SRC.QuantityPerUnit,'')
	 OR ISNULL(DST.UnitPrice,'') <> ISNULL(SRC.UnitPrice,'')
	 OR ISNULL(DST.UnitsInStock,'') <> ISNULL(SRC.UnitsInStock,'')
	 OR ISNULL(DST.UnitsOnOrder,'') <> ISNULL(SRC.UnitsOnOrder,'')
	 OR ISNULL(DST.ReorderLevel,'') <> ISNULL(SRC.ReorderLevel,'')
	 OR ISNULL(DST.Discontinued,'') <> ISNULL(SRC.Discontinued,'')
THEN UPDATE 

SET			 
	  DST.ProductName = SRC.ProductName  
	 ,DST.SupplierID = SRC.SupplierID 
	 ,DST.CategoryID = SRC.CategoryID
	 ,DST.QuantityPerUnit = SRC.QuantityPerUnit
	 ,DST.UnitPrice = SRC.UnitPrice
	 ,DST.UnitsInStock = SRC.UnitsInStock
	 ,DST.ReorderLevel = SRC.ReorderLevel
	 ,DST.Discontinued = SRC.Discontinued
	 ,DST.ValidFrom = GETDATE()

OUTPUT  DELETED.ProductID_NK, DELETED.ProductName, DELETED.SupplierID, DELETED.CategoryID, DELETED.QuantityPerUnit, DELETED.UnitPrice, DELETED.UnitsInStock, DELETED.UnitsOnOrder, DELETED.ReorderLevel, DELETED.Discontinued, DELETED.ValidFrom, $Action AS MergeAction
INTO	@Product_SCD4 (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,ReorderLevel,Discontinued, ValidFrom, MergeAction)
;

-- Update history table to set final date and current flag



UPDATE		TP4

SET			TP4.ValidTo = CONVERT (DATE, GETDATE())

FROM		dbo.DimProducts_SCD4_History TP4
			INNER JOIN @Product_SCD4 TMP
			ON TP4.ProductID_NK = TMP.ProductID_NK

WHERE		TP4.ValidTo IS NULL


INSERT INTO dbo.DimProducts_SCD4_History (ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,ReorderLevel,Discontinued,ValidFrom, ValidTo)

SELECT ProductID_NK, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,ReorderLevel,Discontinued,ValidFrom, GETDATE()
FROM @Product_SCD4
WHERE ProductID_NK IS NOT NULL
