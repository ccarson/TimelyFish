--*************************************************************
--	Purpose:
--		
--	Author: Charity Anderson
--	Date: 12/9/2005
--	Usage: Feed Order Tylan 100 Usage Report
--	Parms: none
--*************************************************************

CREATE View dbo.vXF686TylanUsage

AS
Select fo.*,c.ContactName,
SvcMgr=(Select TOP 1 c.ContactName 
		from cftSiteSvcMgrAsn sa JOIN cftContact c on sa.SvcMgrContactID=c.ContactID
		where SiteContactID=fo.ContactID and sa.EffectiveDate<=fo.DateOrd order by sa.EffectiveDate DESC)
FROM cftFeedOrder fo WITH (NOLOCK)
JOIN cftContact c on fo.ContactID=c.ContactID
where fo.InvtIdDel='055M-TY100' or fo.InvtIdOrd='055M-TY100'
