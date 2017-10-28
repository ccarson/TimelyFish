
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


CREATE   VIEW dbo.cfv_PigGroup_2ndTop
AS
SELECT     pg.PigGroupID, Min(pm.MovementDate) As MinTop, Count(pm.ID) As NoofMoves, Sum(pm.ActualQty) As Qty, Sum(pm.ActualWgt) As Wgt
FROM         dbo.cftPigGroup pg WITH (NOLOCK) INNER JOIN
                      dbo.cftPM pm WITH (NOLOCK) ON pg.SiteContactID = pm.SourceContactID AND pg.BarnNbr = pm.SourceBarnNbr AND pm.MovementDate > pg.EstStartDate AND 
                      pm.MovementDate < pg.EstCloseDate + 30
WHERE     pm.PMTypeID = '02' AND pm.MarketSaleTypeID='20' AND pm.ActualQty>0 AND pm.ActualWgt>0
Group by pg.PigGroupID



 