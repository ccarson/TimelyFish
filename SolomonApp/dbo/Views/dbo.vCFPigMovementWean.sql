
Create View dbo.vCFPigMovementWean

as

SELECT     pm.*,c.ContactName AS SourceFarm,d.ContactName AS Destination 
			FROM dbo.cftPM pm 
	LEFT OUTER JOIN  cftContact c ON pm.SourceContactID = c.ContactID --SourceSiteName
	LEFT OUTER JOIN  cftContact d ON pm.DestContactID = d.ContactID --Destination Name 
WHERE     (c.ContactName <> '') and pm.PigTypeID='02'


