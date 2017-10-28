


Create View [dbo].[vcfPigMovementWeans]

 

as

 

SELECT     pm.*,c.ContactName AS SourceFarm,d.ContactName AS Destination 

                                    FROM dbo.cftpm as pm 

            LEFT OUTER JOIN  cftcontact as c ON pm.SourceContactID = c.ContactID --SourceSiteName

            LEFT OUTER JOIN  cftcontact as d ON pm.destContactID = d.ContactID --Destination Name 

WHERE     (c.ContactName <> '') and pm.PigTypeID='02'

 


