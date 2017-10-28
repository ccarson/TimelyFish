--*************************************************************
--	Purpose:PigGroup Lookup		
--	Author: Charity Anderson
--	Date: 2/11/2005
--	Usage: Pig Flow 
--	Parms: @parm1 (PigGroupID), @parm2 (MovementDate)
--	      
--*************************************************************

CREATE PROC dbo.pXT100PGLKUP
	@parm1 as varchar(10),
	@parm2 as smalldatetime
	
AS
Select p.*, ServiceMan=dbo.GetSvcManagerNm(p.SiteContactID,@parm2,''),
PLC=case when s.PortChuteFlg=-1 then 'Yes' else '' end,g.Description as Gender,
MarketMan=dbo.GetMktManagerNm(p.SiteContactID,@parm2,''),pp.Description as ProdPod
from cftPigGroup p WITH (NOLOCK) 
LEFT JOIN cftSite s WITH (NOLOCK) on p.SiteContactID=s.ContactID
LEFT JOIN cftPigGenderType g WITH (NOLOCK) on p.PigGenderTypeID=g.PigGenderTypeID
LEFT JOIN cftPigProdPod pp WITH (NOLOCK) on p.PigProdPodID=pp.PodID
where p.PigGroupID=@parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100PGLKUP] TO [SOLOMON]
    AS [dbo];

