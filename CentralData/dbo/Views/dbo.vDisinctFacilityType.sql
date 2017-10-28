CREATE VIEW dbo.vDisinctFacilityType
AS
SELECT DISTINCT FacilityTypeID, FacilityType = CASE WHEN FacilityTypeID IS NULL THEN 'None' ELSE FacilityTypeDescription END
FROM         dbo.vHealthServices
