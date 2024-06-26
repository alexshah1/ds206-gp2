MERGE {dst_db}.{dst_schema}.DimCategories_SCD1 AS DST
USING {src_db}.{src_schema}.Categories AS SRC 
ON (DST.CategoryID_NK = SRC.CategoryID)

WHEN MATCHED AND (
    ISNULL(DST.CategoryName, '') <> ISNULL(SRC.CategoryName, '') OR
    ISNULL(DST.Description, '') <> ISNULL(SRC.Description, '')
) THEN 
    UPDATE SET 
        DST.CategoryName = SRC.CategoryName, 
        DST.Description = SRC.Description 

WHEN NOT MATCHED BY TARGET 
THEN INSERT (CategoryID_NK, CategoryName, Description) 
     VALUES (SRC.CategoryID, SRC.CategoryName, SRC.Description)

WHEN NOT MATCHED BY SOURCE 
THEN DELETE;