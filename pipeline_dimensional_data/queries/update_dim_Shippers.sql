MERGE {dst_db}.{dst_schema}.DimShippers_SCD1 AS DST
USING {src_db}.{src_schema}.Shippers AS SRC
ON (SRC.ShipperID = DST.ShipperID_NK)

WHEN MATCHED AND (
    ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '') OR
    ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '')
) THEN
    UPDATE SET 
        DST.CompanyName = SRC.CompanyName,
        DST.Phone = SRC.Phone

WHEN NOT MATCHED BY TARGET
THEN  INSERT (ShipperID_NK, CompanyName, Phone)
      VALUES (SRC.ShipperID, SRC.CompanyName, SRC.Phone);