CREATE PROC [dbo].[pSourceSitesFiltered] 
	          @MovementDate as varchar(10), 
 		  @ListStr as varchar(100)
            
            As
DECLARE @SQLStr varchar(800)
SELECT @SQLStr = 'Select s.* 
            FROM vSourceSites s
            LEFT OUTER JOIN SitePigFlow spf on s.ContactID=spf.ContactID
		JOIN (Select Max(EffectiveDate) as EffectiveDate, ContactID from SitePigFlow  
                       Where EffectiveDate <= ' + CHAR(39) + @MovementDate + CHAR(39) +' GROUP BY ContactID) dPigFlow
		ON dPigFlow.EffectiveDate=spf.EffectiveDate and dPigFlow.ContactID=spf.ContactID
            WHERE (convert(varchar(10),spf.pigflowid) in ('  
            + @ListStr + ')) Order by s.ContactName'
            EXEC (@SQLStr)
