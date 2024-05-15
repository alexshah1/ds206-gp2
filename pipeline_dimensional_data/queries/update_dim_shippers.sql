BEGIN TRY
MERGE {dst_db}.{dst_schema}.DimShippers_SCD1 AS TARGET -- destination
USING {src_db}.{src_schema}.Shippers AS SOURCE -- source
ON (SOURCE.ShipperID = TARGET.ShipperID_NK)
WHEN NOT MATCHED BY TARGET THEN 
  INSERT (ShipperID_NK,
		  CompanyName,
          Phone)
  VALUES (SOURCE.ShipperID,
		  SOURCE.CompanyName,
          SOURCE.Phone)
WHEN NOT MATCHED BY SOURCE
THEN DELETE 
WHEN MATCHED AND (  
	ISNULL(TARGET.ShipperID_NK, '') <> ISNULL(SOURCE.ShipperID, '') OR
	ISNULL(TARGET.CompanyName, '') <> ISNULL(SOURCE.CompanyName, '') OR
	ISNULL(TARGET.Phone, '') <> ISNULL(SOURCE.Phone, '')  ) 
	THEN
		UPDATE SET 
			 TARGET.ShipperID_NK = SOURCE.ShipperID,
			 TARGET.CompanyName = SOURCE.CompanyName,
             TARGET.Phone = SOURCE.Phone; 
END TRY
BEGIN CATCH
    THROW
END CATCH
GO

