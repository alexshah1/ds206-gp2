DECLARE @Today DATE = CONVERT(DATE, GETDATE());
DECLARE @Yesterday DATE = CONVERT(DATE, DATEADD(DAY, -1, @Today));

DECLARE @Supplier_SCD4 TABLE
(
	SupplierID_NK INT,
    CompanyName NVARCHAR(100),
    ContactName NVARCHAR(100),
    ContactTitle NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    Region NVARCHAR(100),
    PostalCode NVARCHAR(20),
    Country NVARCHAR(100),
    Phone NVARCHAR(20),
    Fax NVARCHAR(20),
    HomePage NVARCHAR(255),
	ValidFrom DATE,
	MergeAction NVARCHAR(10) 
) 

MERGE {dst_db}.{dst_schema}.DimSuppliers_SCD1 AS DST
USING {src_db}.{src_schema}.Suppliers AS SRC
ON (SRC.SupplierID = DST.SupplierID_NK)

WHEN NOT MATCHED THEN
    INSERT (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom)
    VALUES (SRC.SupplierID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, SRC.HomePage, @Today)

WHEN MATCHED AND (
        ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '') OR
        ISNULL(DST.ContactName, '') <> ISNULL(SRC.ContactName, '') OR
        ISNULL(DST.ContactTitle, '') <> ISNULL(SRC.ContactTitle, '') OR
        ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '') OR
        ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
        ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
        ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
        ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
        ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '') OR
        ISNULL(DST.Fax, '') <> ISNULL(SRC.Fax, '') OR
        ISNULL(DST.HomePage, '') <> ISNULL(SRC.HomePage, '')
    )
THEN 
    UPDATE SET 
        DST.CompanyName = SRC.CompanyName,
        DST.ContactName = SRC.ContactName,
        DST.ContactTitle = SRC.ContactTitle,
        DST.Address = SRC.Address,
        DST.City = SRC.City,
        DST.Region = SRC.Region,
        DST.PostalCode = SRC.PostalCode,
        DST.Country = SRC.Country,
        DST.Phone = SRC.Phone,
        DST.Fax = SRC.Fax,
        DST.HomePage = SRC.HomePage,
        DST.ValidFrom = @Today

OUTPUT 
    DELETED.SupplierID_NK, 
    DELETED.CompanyName, 
    DELETED.ContactName, 
    DELETED.ContactTitle, 
    DELETED.Address, 
    DELETED.City, 
    DELETED.Region, 
    DELETED.PostalCode, 
    DELETED.Country, 
    DELETED.Phone, 
    DELETED.Fax, 
    DELETED.HomePage, 
    DELETED.ValidFrom, 
    $ACTION AS MergeAction
INTO @Supplier_SCD4 (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom, MergeAction);

INSERT INTO {dst_db}.{dst_schema}.DimSuppliers_SCD4_History (SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom, ValidTo, MergeAction)
SELECT SupplierID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage, ValidFrom, @Yesterday, MergeAction
FROM @Supplier_SCD4
WHERE SupplierID_NK IS NOT NULL;
