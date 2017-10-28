--*************************************************************
--	Purpose:Project Lookup		
--	Author: Charity Anderson
--	Date: 2/10/2005
--	Usage: Pig Flow 
--	Parms: @parm1 (ContactID), @parm2 (MovementDate)
--	      
--*************************************************************

CREATE PROC dbo.pXT100ProjLKUP
	@parm1 as varchar(6),
	@parm2 as smalldatetime
	
AS
Select p.*, ServiceMan=dbo.GetSvcManagerNm(@parm1,@parm2,''), s.ContactID,
PLC=case when s.PortChuteFlg=-1 then 'Yes' else '' end,
MarketMan=dbo.GetMktManagerNm(@parm1,@parm2,''),
ProdPod=(Select Top 1 pp.Description 
		from cftSitePod sp JOin cftPigProdPod pp on sp.PodID=pp.PodID
		where sp.EffectiveDate<=@parm2 and ContactID=@parm1
		order by sp.EffectiveDate Desc)
from PJProj p WITH (NOLOCK) 
JOIN cftSite s WITH (NOLOCK) on 
	p.Project = (Select ProjectPrefix from cftPGSetup) + s.SiteID
where s.ContactID = @parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100ProjLKUP] TO [SOLOMON]
    AS [dbo];

