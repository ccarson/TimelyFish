
CREATE  VIEW cfvCurrentSvcMgr
	AS
	-- This view is used to display the current service manager 
select 
s.sitecontactid,
s.svcmgrcontactid,
effectivedate
from cftSiteSvcMgrAsn s
where svcmgrcontactid <> ''
	AND EffectiveDate = 
	(Select max(effectivedate) From cftSiteSvcMgrAsn
			WHERE SiteContactID = s.SiteContactID AND
			EffectiveDate <= GetDate())


 