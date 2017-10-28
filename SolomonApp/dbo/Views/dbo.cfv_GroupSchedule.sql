
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  View dbo.cfv_GroupSchedule    Script Date: 3/11/2005 9:36:47 AM ******/

/****** ALTER  by: Sue Matter ******/
/****** Next Scheduled Transport for Pig Group  Script Date: 3/11/2005 ******/
/****** Used On George's Inventory by Date ******/

CREATE View cfv_GroupSchedule
AS
select pg.SiteContactID As GroupContact, pg.BarnNbr As GroupBarn, pg.PigGroupID, 
pg.EstCloseDate As GroupEstClose,  pm.SourceContactID As TranpContact, pm.SourceBarnNbr As TranspBarn, 
pm.MovementDate, pm.EstimatedQty, pm.EstimatedWgt, pm.ArrivalDate, pm.ActualQty, PM.PMID, PM.PMTypeID
From cftPigGroup pg
LEFT JOIN cftPM pm ON pg.SiteContactID=pm.SourceContactID AND pg.BarnNbr=pm.SourceBarnNbr 
Where pg.PGStatusID <>'I' AND pm.DeleteFlag<>'1'
AND pm.PMID IN (Select Max(pm2.PMID)
from cftPM pm2
Group by pm2.SOurceContactID, pm2.SourceBarnNbr) AND pm.ActualQty='0'







 