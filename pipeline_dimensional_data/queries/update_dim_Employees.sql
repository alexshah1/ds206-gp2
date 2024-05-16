DECLARE @Today DATE = CONVERT(DATE, GETDATE());
DECLARE @Yesterday DATE = CONVERT(DATE, DATEADD(DAY, -1, @Today));

DECLARE @Employees_SCD4 TABLE
(
    EmployeeID_NK INT,
    LastName NVARCHAR(255),
    FirstName NVARCHAR(255),
    Title NVARCHAR(255),
    TitleOfCourtesy NVARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Address NVARCHAR(50),
    City NVARCHAR(255),
    Region NVARCHAR(255),
    PostalCode NVARCHAR(20),
    Country NVARCHAR(100),
    HomePhone NVARCHAR(50),
    Extension INT,
    Notes NVARCHAR(MAX),
    ReportsTo INT,
    PhotoPath NVARCHAR(255),
    ValidFrom DATE DEFAULT  current_timestamp,
    MergeAction NVARCHAR(10)
) 

MERGE {dst_db}.{dst_schema}.DimEmployees_SCD1 AS DST
USING {src_db}.{src_schema}.Employees AS SRC
ON (SRC.EmployeeID = DST.EmployeeID_NK)

WHEN NOT MATCHED THEN
    INSERT (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom)
    VALUES (SRC.EmployeeID, SRC.LastName, SRC.FirstName, SRC.Title, SRC.TitleOfCourtesy, SRC.BirthDate, SRC.HireDate, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.HomePhone, SRC.Extension, SRC.Notes, SRC.ReportsTo, SRC.PhotoPath, @Today)

WHEN MATCHED AND (
        ISNULL(DST.LastName, '') <> ISNULL(SRC.LastName, '') OR
        ISNULL(DST.FirstName, '') <> ISNULL(SRC.FirstName, '') OR
        ISNULL(DST.Title, '') <> ISNULL(SRC.Title, '') OR
        ISNULL(DST.TitleOfCourtesy, '') <> ISNULL(SRC.TitleOfCourtesy, '') OR
        ISNULL(DST.BirthDate, '') <> ISNULL(SRC.BirthDate, '') OR
        ISNULL(DST.HireDate, '') <> ISNULL(SRC.HireDate, '') OR
        ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '') OR
        ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
        ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
        ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
        ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
        ISNULL(DST.HomePhone, '') <> ISNULL(SRC.HomePhone, '') OR
        ISNULL(DST.Extension, '') <> ISNULL(SRC.Extension, '') OR
        ISNULL(DST.Notes, '') <> ISNULL(SRC.Notes, '') OR
        ISNULL(DST.ReportsTo, '') <> ISNULL(SRC.ReportsTo, '') OR
        ISNULL(DST.PhotoPath, '') <> ISNULL(SRC.PhotoPath, '')
    )
THEN 
    UPDATE SET 
        DST.LastName = SRC.LastName,
        DST.FirstName = SRC.FirstName,
        DST.Title = SRC.Title,
        DST.TitleOfCourtesy = SRC.TitleOfCourtesy,
        DST.BirthDate = SRC.BirthDate,
        DST.HireDate = SRC.HireDate,
        DST.Address = SRC.Address,
        DST.City = SRC.City,
        DST.Region = SRC.Region,
        DST.PostalCode = SRC.PostalCode,
        DST.Country = SRC.Country,
        DST.HomePhone = SRC.HomePhone,
        DST.Extension = SRC.Extension,
        DST.Notes = SRC.Notes,
        DST.ReportsTo = SRC.ReportsTo,
        DST.PhotoPath = SRC.PhotoPath,
        DST.ValidFrom = GETDATE()
OUTPUT 
    DELETED.EmployeeID_NK, 
    DELETED.LastName, 
    DELETED.FirstName, 
    DELETED.Title, 
    DELETED.TitleOfCourtesy, 
    DELETED.BirthDate, 
    DELETED.HireDate, 
    DELETED.Address, 
    DELETED.City,  
    DELETED.Region, 
    DELETED.PostalCode, 
    DELETED.Country, 
    DELETED.HomePhone, 
    DELETED.Extension, 
    DELETED.Notes, 
    DELETED.ReportsTo, 
    DELETED.PhotoPath, 
    DELETED.ValidFrom, 
    $ACTION AS MergeAction
INTO @Employees_SCD4 (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, MergeAction);

INSERT INTO {dst_db}.{dst_schema}.DimEmployees_SCD4_History (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, ValidTo, MergeAction)
SELECT EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, @Yesterday, MergeAction
FROM @Employees_SCD4
WHERE EmployeeID_NK IS NOT NULL;
