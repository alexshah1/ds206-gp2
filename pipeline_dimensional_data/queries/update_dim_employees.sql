
DECLARE  @Employees_SCD4 TABLE
(
    [EmployeeID_NK] [int] NULL,
    [LastName] [nvarchar](255) NULL,
    [FirstName] [nvarchar](255) NULL,
    [Title] [nvarchar](255) NULL,
    [TitleOfCourtesy] [nvarchar](50) NULL,
    [BirthDate] [datetime] NULL,
    [HireDate] [datetime] NULL,
    [Address] [nvarchar](50) NULL,
    [City] [nvarchar](255) NULL,
    [Region] [nvarchar](255) NULL,
    [PostalCode] [nvarchar](20) NULL,
    [Country] [nvarchar](100) NULL,
    [HomePhone] [nvarchar](50) NULL,
    [Extension] [int] NULL,
    [Notes] [nvarchar](MAX) NULL,
    [ReportsTo] [int] NULL,
    [PhotoPath] [nvarchar](255) NULL,
	[ValidFrom] [datetime] NULL,
	[MergeAction] [varchar](10) NULL

) 

-- Merge statement
MERGE		dbo.DimEmployees_SCD1 AS DST
USING		Employees AS SRC
ON			(SRC.EmployeeID_NK = DST.EmployeeID_NK)

WHEN NOT MATCHED THEN

INSERT (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom)
VALUES (SRC.EmployeeID_NK, SRC.LastName, SRC.FirstName, SRC.Title, SRC.TitleOfCourtesy, SRC.BirthDate, SRC.HireDate, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.HomePhone, SRC.Extension, SRC.Notes, SRC.ReportsTo, SRC.PhotoPath, GETDATE())

WHEN MATCHED 
AND		
	 ISNULL(DST.LastName,'') <> ISNULL(SRC.LastName,'')  
	 OR ISNULL(DST.FirstName,'') <> ISNULL(SRC.FirstName,'') 
	 OR ISNULL(DST.Title,'') <> ISNULL(SRC.Title,'')
	 OR ISNULL(DST.TitleOfCourtesy,'') <> ISNULL(SRC.TitleOfCourtesy,'')
	 OR ISNULL(DST.BirthDate,'') <> ISNULL(SRC.BirthDate,'')
	 OR ISNULL(DST.HireDate,'') <> ISNULL(SRC.HireDate,'')
	 OR ISNULL(DST.Address,'') <> ISNULL(SRC.Address,'')
	 OR ISNULL(DST.City,'') <> ISNULL(SRC.City,'') 
	 OR ISNULL(DST.Region,'') <> ISNULL(SRC.Region,'')
	 OR ISNULL(DST.PostalCode,'') <> ISNULL(SRC.PostalCode,'')
	 OR ISNULL(DST.Country,'') <> ISNULL(SRC.Country,'')
	 OR ISNULL(DST.HomePhone,'') <> ISNULL(SRC.HomePhone,'')
	 OR ISNULL(DST.Extension,'') <> ISNULL(SRC.Extension,'')
	 OR ISNULL(DST.Notes,'') <> ISNULL(SRC.Notes,'')
	 OR ISNULL(DST.ReportsTo,'') <> ISNULL(SRC.ReportsTo,'')
	 OR ISNULL(DST.PhotoPath,'') <> ISNULL(SRC.PhotoPath, '')
THEN UPDATE 

SET			 
	 DST.LastName = SRC.LastName  
	 ,DST.FirstName = SRC.FirstName
	 ,DST.Title = SRC.Title
	 ,DST.TitleOfCourtesy = SRC.TitleOfCourtesy
	 ,DST.BirthDate = SRC.BirthDate
	 ,DST.HireDate = SRC.HireDate
	 ,DST.Address = SRC.Address
	 ,DST.City = SRC.City
	 ,DST.Region = SRC.Region
	 ,DST.PostalCode = SRC.PostalCode
	 ,DST.Country = SRC.Country
	 ,DST.HomePhone = SRC.HomePhone
	 ,DST.Extension = SRC.Extension
	 ,DST.Notes = SRC.Notes
	 ,DST.ReportsTo = SRC.ReportsTo
	 ,DST.PhotoPath = SRC.PhotoPath
	 ,DST.ValidFrom = GETDATE()

OUTPUT DELETED.EmployeeID_NK, DELETED.LastName, DELETED.FirstName, DELETED.Title, DELETED.TitleOfCourtesy, DELETED.BirthDate, DELETED.HireDate, DELETED.Address, DELETED.City,  DELETED.Region, DELETED.PostalCode, DELETED.Country, DELETED.HomePhone, DELETED.Extension, DELETED.Notes, DELETED.ReportsTo, DELETED.PhotoPath, DELETED.ValidFrom, $Action AS MergeAction
INTO @Employees_SCD4 (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, MergeAction)
;

-- Handle deletions
    DELETE FROM dbo.DimEmployees_SCD1
    OUTPUT DELETED.EmployeeID_NK, DELETED.LastName, DELETED.FirstName, DELETED.Title, DELETED.TitleOfCourtesy, DELETED.BirthDate, DELETED.HireDate, DELETED.Address, DELETED.City, DELETED.Region, DELETED.PostalCode, DELETED.Country, DELETED.HomePhone, DELETED.Extension, DELETED.Notes, DELETED.ReportsTo, DELETED.PhotoPath, DELETED.ValidFrom, 'DELETE' AS MergeAction
    INTO @Employees_SCD4 (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, MergeAction)
    WHERE EmployeeID_NK NOT IN (SELECT EmployeeID_NK FROM Employees);

-- Update history table to set final date and current flag

UPDATE		TP4

SET			TP4.ValidTo = DATEADD(day, -1, GETDATE())

FROM		dbo.DimEmployees_SCD4_History TP4
			INNER JOIN @Employees_SCD4 TMP
			ON TP4.EmployeeID_NK = TMP.EmployeeID_NK

WHERE		TP4.ValidTo IS NULL


-- Add latest history records to history table
INSERT INTO dbo.DimEmployees_SCD4_History (EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, ValidTo)
SELECT EmployeeID_NK, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo, PhotoPath, ValidFrom, DATEADD(DAY, -1, GETDATE())
FROM @Employees_SCD4
WHERE EmployeeID_NK IS NOT NULL;
