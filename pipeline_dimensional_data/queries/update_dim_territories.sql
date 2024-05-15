DECLARE @Yesterday INT = (YEAR(DATEADD(dd, - 1, GETDATE())) * 10000) + (MONTH(DATEADD(dd, - 1, GETDATE())) * 100) + DAY(DATEADD(dd, - 1, GETDATE()));

MERGE DimTerritories_SCD3 AS DST
USING 
(SELECT *
FROM Territories) SRC
ON (SRC.TerritoryID = DST.TerritoryID_NK)
WHEN NOT MATCHED THEN
INSERT (TerritoryID_NK, TerritoryDescription, RegionID_NK_FK)
VALUES (SRC.TerritoryID_NK, SRC.TerritoryDescription, SRC.RegionID)
WHEN MATCHED
AND 
	(
	ISNULL(DST.TerritoryDescription, '') <> ISNULL(SRC.TerritoryDescription, '') OR
	ISNULL(DST.RegionID_NK_FK, '') <> ISNULL(SRC.RegionID, '')
)
THEN 
	UPDATE 
	SET
	,DST.TerritoryDescription = SRC.TerritoryDescription
	,DST.TerritoryDescription_Prev1 = (CASE WHEN DST.TerritoryDescription <> SRC.TerritoryDescription THEN DST.TerritoryDescription ELSE DST.TerritoryDescription_Prev1 END)
    ,DST.TerritoryDescription_Prev1_ValidTo = (CASE WHEN DST.TerritoryDescription <> SRC.TerritoryDescription THEN @Yesterday ELSE DST.TerritoryDescription_Prev1_ValidTo END)
	,DST.TerritoryDescription_Prev2 = (CASE WHEN DST.TerritoryDescription <> SRC.TerritoryDescription THEN DST.TerritoryDescription_Prev1 ELSE DST.TerritoryDescription_Prev2 END)
    ,DST.TerritoryDescription_Prev2_ValidTo = (CASE WHEN DST.TerritoryDescription <> SRC.TerritoryDescription THEN @Yesterday ELSE DST.TerritoryDescription_Prev2_ValidTo END),
	,DST.RegionID_NK_FK = SRC.RegionID,
	,DST.RegionID_NK_FK_Prev1 = (CASE WHEN DST.RegionID_NK_FK <> SRC.RegionID THEN DST.RegionID_NK_FK ELSE DST.RegionID_NK_FK_Prev1 END)
    ,DST.RegionID_NK_FK_Prev1_ValidTo = (CASE WHEN DST.RegionID_NK_FK <> SRC.RegionID THEN @Yesterday ELSE DST.RegionID_NK_FK_Prev1_ValidTo END)
	,DST.RegionID_NK_FK_Prev2 = (CASE WHEN DST.RegionID_NK_FK <> SRC.RegionID THEN DST.RegionID_NK_FK_Prev1 ELSE DST.RegionID_NK_FK_Prev2 END)
    ,DST.RegionID_NK_FK_Prev2_ValidTo = (CASE WHEN RegionID_NK_FK <> SRC.RegionID THEN @Yesterday ELSE DST.RegionID_NK_FK_Prev2_ValidTo END);