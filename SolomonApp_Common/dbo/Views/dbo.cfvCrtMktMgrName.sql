CREATE  VIEW cfvCrtMktMgrName
	AS
---------------------------------------------------------------------------------------
-- PURPOSE:Display the current market service manager
-- CREATED BY: CANDERSON
-- CREATED ON: 9/14/2005
-- USED BY: FEED REPORTING
---------------------------------------------------------------------------------------

select 
sv.sitecontactid,
SvcMgrContactid = sv.MktMgrContactID,
ct.ContactName,
Effectivedate = sv.effectivedate
from dbo.cfvCurrentMktSvcMgr sv
LEFT JOIN cftContact ct ON sv.MktMgrContactID = ct.ContactID

