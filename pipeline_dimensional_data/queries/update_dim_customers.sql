INSERT INTO DimCustomers_SCD2 (CustomerID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, ValidFrom, IsCurrent)
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, GETDATE(), 1
FROM(
	MERGE DimCustomers_SCD2 AS DST
	USING Customers AS SRC
	ON (SRC.CustomerID = DST.CustomerID_NK)
	WHEN NOT MATCHED
    THEN
	  INSERT (CustomerID_NK, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, ValidFrom, IsCurrent)
	  VALUES (SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, GETDATE(), 1)
	WHEN MATCHED
        AND IsCurrent = 1  
        AND (
		ISNULL(DST.CompanyName, '') <> ISNULL(SRC.CompanyName, '')
        OR ISNULL(DST.ContactName, '') <> ISNULL(SRC.ContactName, '')
        OR ISNULL(DST.ContactTitle, '') <> ISNULL(SRC.ContactTitle, '')
        OR ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '')
        OR ISNULL(DST.City, '') <> ISNULL(SRC.City, '')
        OR ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '')
        OR ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '')
        OR ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '')
        OR ISNULL(DST.Phone, '') <> ISNULL(SRC.Phone, '')
        OR ISNULL(DST.Fax, '') <> ISNULL(SRC.Fax, ''))
	  THEN
		UPDATE
        SET
		   DST.IsCurrent = 0, 
		   DST.ValidTo = GETDATE()
		   OUTPUT SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, $Action AS MergeAction
) AS MRG
WHERE MRG.MergeAction = 'UPDATE' ;
