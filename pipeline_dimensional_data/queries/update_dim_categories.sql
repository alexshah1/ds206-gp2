MERGE {dst_db}.{dst_schema}.DimCategories_SCD1 AS DST
USING {src_db}.{src_schema}.Categories AS SRC 
ON (DST.ProductID_NK = SRC.ProductID) 

WHEN MATCHED AND 
    ISNULL(DST.CategoryName, '') <> ISNULL(SRC.CategoryName, '') OR
    ISNULL(DST.Description, '') <> ISNULL(SRC.Description, '') 
THEN UPDATE SET DST.CategoryName = SRC.CategoryName, DST.Description = SRC.Description 

WHEN NOT MATCHED BY DST 
THEN INSERT (CategoryID_NK, CategoryName, Description) VALUES (SRC.CategoryID, SRC.CategoryName, SRC.Description)

WHEN NOT MATCHED BY SRC 
THEN DELETE 

OUTPUT $action, 
DELETED.CategoryID_NK AS DstCategoryID, 
DELETED.CategoryName AS DstCategoryName, 
DELETED.Description AS DstDescription, 
INSERTED.CategoryID_NK AS SrcCategoryID, 
INSERTED.CategoryName AS SrcCategoryName, 
INSERTED.Description AS SrcDescription; 

-- SELECT @@ROWCOUNT;