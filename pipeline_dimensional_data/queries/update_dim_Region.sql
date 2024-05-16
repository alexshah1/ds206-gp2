DECLARE @Yesterday DATE = CONVERT(DATE, DATEADD(DAY, -1, GETDATE()));

MERGE INTO {dst_db}.{dst_schema}.DimRegion_SCD3 AS DST
USING (
    SELECT RegionID, RegionDescription
    FROM {src_db}.{src_schema}.Region
) SRC
ON (SRC.RegionID = DST.RegionID_NK)
WHEN NOT MATCHED THEN
    INSERT (RegionID_NK, RegionDescription)
    VALUES (SRC.RegionID, SRC.RegionDescription)
WHEN MATCHED AND (
    ISNULL(DST.RegionDescription, '') <> ISNULL(SRC.RegionDescription, '')
) THEN 
    UPDATE SET 
        DST.RegionDescription = SRC.RegionDescription,
        DST.RegionDescription_Prev1 = CASE 
            WHEN DST.RegionDescription <> SRC.RegionDescription THEN DST.RegionDescription 
            ELSE DST.RegionDescription_Prev1 
        END,
        DST.RegionDescription_Prev1_ValidTo = CASE 
            WHEN DST.RegionDescription <> SRC.RegionDescription THEN @Yesterday 
            ELSE DST.RegionDescription_Prev1_ValidTo 
        END,
        DST.RegionDescription_Prev2 = CASE 
            WHEN DST.RegionDescription <> SRC.RegionDescription THEN DST.RegionDescription_Prev1 
            ELSE DST.RegionDescription_Prev2 
        END,
        DST.RegionDescription_Prev2_ValidTo = CASE 
            WHEN DST.RegionDescription <> SRC.RegionDescription THEN DST.RegionDescription_Prev1_ValidTo 
            ELSE DST.RegionDescription_Prev2_ValidTo 
        END;
