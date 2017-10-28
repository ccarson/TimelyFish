CREATE VIEW dbo.cfv_CURRENT_SITE_SERVICE_MANAGER
AS

SELECT 
	MaxSiteSvcMgr.SiteContactID
,	ContactSite.ContactName SiteName
,	ContactSvcMgr.ContactID ServiceManagerContactID
,	ContactSvcMgr.ContactName ServiceManagerName
,	MaxSiteSvcMgr.EffectiveDate
FROM (select SiteContactID, max(EffectiveDate) EffectiveDate 
	FROM  dbo.SiteSvcMgrAssignment (nolock)
	group by SiteContactID) MaxSiteSvcMgr
left join  dbo.Contact ContactSite (nolock)
	on ContactSite.ContactID = MaxSiteSvcMgr.SiteContactID
left join  dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment (nolock)
	on SiteSvcMgrAssignment.SiteContactID = MaxSiteSvcMgr.SiteContactID
	and SiteSvcMgrAssignment.EffectiveDate = MaxSiteSvcMgr.EffectiveDate
left join  dbo.Contact ContactSvcMgr (nolock)
	on ContactSvcMgr.ContactID = SiteSvcMgrAssignment.SvcMgrContactID

GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_CURRENT_SITE_SERVICE_MANAGER] TO PUBLIC
    AS [dbo];

