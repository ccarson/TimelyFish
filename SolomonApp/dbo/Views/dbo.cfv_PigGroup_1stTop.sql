
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  View dbo.cfv_PigGroup_1stTop    Script Date: 6/20/2005 3:14:17 PM ******/


CREATE    VIEW dbo.cfv_PigGroup_1stTop
AS
SELECT     pg.PigGroupID, Min(pm.MovementDate) As MinTop, Count(pm.ID) As NoofMoves, Sum(pm.ActualQty) As Qty, Sum(pm.ActualWgt) As Wgt
FROM         dbo.cftPigGroup pg WITH (NOLOCK) INNER JOIN
                      dbo.cftPM pm WITH (NOLOCK) ON pg.SiteContactID = pm.SourceContactID AND pg.BarnNbr = pm.SourceBarnNbr AND pm.MovementDate > pg.EstStartDate AND 
                      pm.MovementDate < pg.EstCloseDate + 30
WHERE     pm.PMTypeID = '02' AND pm.MarketSaleTypeID='10' AND pm.ActualQty>0 AND pm.ActualWgt>0
Group by pg.PigGroupID




 