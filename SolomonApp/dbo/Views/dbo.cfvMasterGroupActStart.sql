
--*************************************************************
--	Purpose:Master Group Start Date
--		
--	Author: Charity Anderson
--	Date: 7/20/2005
--	Usage: EssBase 
--	Parms: vCFPigGroupAttribute, vCFPigSaleEssBase
--	Modified:  9/21/2007 SM
--	Changed 3rd field to TranDate in vCFPigGroupStart this is the min tran date
--*************************************************************
CREATE VIEW cfvMasterGroupActStart 
AS

Select mg.CF03 as MGPigGroupID,mg.SiteContactID, 
--min(mg.ActStartDate) as StartDate
min(gs.TranDate) as StartDate,ms.MCostFlag, ms.MPGStatusID, 
gt.Description AS MPigGenderTypeID, pd.Description AS MPigProdPodID, ms.MSvcMgrContactID 
from cftPigGroup mg WITH (NOLOCK)
LEFT JOIN vCFPigGroupStart gs on mg.PigGroupID=gs.PigGroupID
LEFT JOIN cftPigGroupMaster ms ON mg.CF03=ms.MPigGroupID
LEFT JOIN cftPigProdPod pd ON ms.MPigProdPodID=pd.PodID
LEFT JOIN cftPigGenderType gt ON ms.MPigGenderTypeID=gt.PigGenderTypeID
where  mg.ActStartDate>'1/1/1900' AND mg.PGStatusID<>'X'
group by mg.CF03,mg.SiteContactID,ms.MCostFlag, ms.MPGStatusID, gt.Description, pd.Description, ms.MSvcMgrContactID 
