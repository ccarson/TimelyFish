
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  View dbo.vCFPigGroupPMMarkets    Script Date: 5/17/2005 1:49:10 PM ******/
CREATE  VIEW dbo.vCFPigGroupPMMarkets
AS
SELECT     pg.PigGroupID, pm.MovementDate, pm.MarketSaleTypeID
FROM         dbo.cftPigGroup pg WITH (NOLOCK) INNER JOIN
                      dbo.cftPM pm WITH (NOLOCK) ON pg.SiteContactID = pm.SourceContactID AND pg.BarnNbr = pm.SourceBarnNbr AND pm.MovementDate > pg.EstStartDate AND 
                      pm.MovementDate < pg.EstCloseDate + 30
WHERE     (pm.PMTypeID = '02')


 