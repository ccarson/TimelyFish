


CREATE     VIEW [dbo].[cfvSiteSvcMgrName_20131008]
	AS
---------------------------------------------------------------------------------------
-- PURPOSE:Display the current  service manager and Site Name
-- CREATED BY: DDahle
-- CREATED ON: 7/18/2012
-- USED BY: Farm Site Eval
---------------------------------------------------------------------------------------

select 
sv.sitecontactid,
ct2.ContactName siteName,
sv.SvcMgrContactID,
ct.ContactName  SvcMgrName,
max( sv.effectivedate) effectivedate
from dbo.cfvCurrentSvcMgr sv (nolock)
LEFT JOIN cftContact ct ON sv.SvcMgrContactID = ct.ContactID
LEFT JOIN cftContact ct2 ON sv.sitecontactid = ct2.ContactID
where ct2.[StatusTypeID] = 1 
group by [sitecontactid],ct2.ContactName,[SvcMgrContactid],ct.ContactName

