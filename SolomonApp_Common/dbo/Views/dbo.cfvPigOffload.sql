
--*************************************************************
--	Purpose:Pig Movement Offloads
--		
--	Author: Charity Anderson
--	Date: 10/21/2005
--	Usage: EssBase 
--	Parms: vCFPigSaleEssBase
--*************************************************************
CREATE VIEW cfvPigOffload 
AS
Select pm.PMID as OrigPMID, pm.TranSubTypeID,
PMID=Case when right(rtrim(pm.TranSubTypeID),1)='O' then 
--o.DestPMID
o.DestPMID
else
pm.PMID end

From cftPigSale ps join cftPM pm on ps.PMLoadID=pm.PMID
LEFT JOIN cftPigOffload o on cast(pm.PMID as Integer)=o.SrcPMID
