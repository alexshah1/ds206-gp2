BEGIN TRY
MERGE DimShippers_SCD1 AS TARGET -- destination
USING Shippers AS SOURCE -- source
ON ( SOURCE.ShipperID = TARGET.ShipperID_NK)
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
	Isnull(TARGET.ShipperID_NK, '') <> Isnull(SOURCE.ShipperID, '') OR
	Isnull(TARGET.CompanyName, '') <> Isnull(SOURCE.CompanyName, '') OR
	Isnull(TARGET.Phone, '') <> Isnull(SOURCE.Phone, '')  ) 
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

