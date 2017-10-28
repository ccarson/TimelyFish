


CREATE      VIEW cfvSiteDetailMgr
	AS
---------------------------------------------------------------------------------------
-- PURPOSE:Display the current  service manager by Site ID
-- CREATED BY: SMATTER
-- CREATED ON: 12/8/2006
-- USED BY: Kronos Site Reports
---------------------------------------------------------------------------------------

select 
--sv.sitecontactid,
st.SiteID,
--ct2.ContactName As SiteName,
SvcMgrContactid = sv.SvcMgrContactID,
ct.ContactName--,
--Effectivedate = Max(sv.effectivedate)
from cftSite st
JOIN cftContact ct2 ON st.ContactID=ct2.ContactID
LEFT JOIN cfvCurrentSvcMgr sv ON st.ContactID=sv.SiteContactID
LEFT JOIN cftContact ct ON sv.SvcMgrContactID = ct.ContactID
--Where effectivedate = (Select Max(EffectiveDate) from cfvCurrentSvcMgr z Where z.SitecontactID=st.ContactID)
Group by st.SiteID, sv.SvcMgrContactID, ct.ContactName





