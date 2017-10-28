



CREATE     VIEW [dbo].[cfvCrtSvcMgrName]
	AS
---------------------------------------------------------------------------------------
-- PURPOSE:Display the current  service manager
-- CREATED BY: CANDERSON
-- CREATED ON: 9/14/2005
-- USED BY: FEED REPORTING
-- 2012-07-11 smr added (nolock) to table cftcontact
---------------------------------------------------------------------------------------

select 
sv.sitecontactid,
SvcMgrContactid = sv.SvcMgrContactID,
ct.ContactName,
Effectivedate = sv.effectivedate
from dbo.cfvCurrentSvcMgr sv (nolock)
LEFT JOIN cftContact ct (nolock) ON sv.SvcMgrContactID = ct.ContactID



