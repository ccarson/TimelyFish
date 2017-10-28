CREATE VIEW cfv_SITE_MANAGEMENT_INFO
AS
SELECT 
	Site.ContactID
,	Site.SiteID
,	SiteContact.ContactName SiteName
,	SiteMgrContact.ContactName SiteManager
,	SiteSvcMgrContact.ContactName SiteServiceManager
,	SiteSrSvcMgrContact.ContactName SiteSrServiceManager
,	SiteMktSvcMgrContact.ContactName SiteMktServiceManager
,	FacilityType.FacilityTypeDescription
--,	Site.*
FROM		dbo.Site Site (NOLOCK)
LEFT JOIN	dbo.Contact SiteContact (NOLOCK)
	ON SiteContact.ContactID = Site.ContactID
LEFT JOIN	dbo.FacilityType FacilityType (NOLOCK)
	ON FacilityType.FacilityTypeID = Site.FacilityTypeID
LEFT JOIN	dbo.Contact SiteMgrContact (NOLOCK)
	ON SiteMgrContact.ContactID = Site.SiteMgrContactID

LEFT JOIN	(SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate 
			FROM dbo.SiteSvcMgrAssignment (NOLOCK) GROUP BY SiteContactID) CurrSiteSvcMgr
	ON CurrSiteSvcMgr.SiteContactID = Site.ContactID
LEFT JOIN dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment (NOLOCK)
	ON SiteSvcMgrAssignment.SiteContactID = CurrSiteSvcMgr.SiteContactID
	AND SiteSvcMgrAssignment.EffectiveDate = CurrSiteSvcMgr.EffectiveDate
LEFT JOIN	dbo.Contact SiteSvcMgrContact (NOLOCK)
	ON SiteSvcMgrContact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID

LEFT JOIN	(SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate 
			FROM dbo.MarketSvcMgrAssignment (NOLOCK) GROUP BY SiteContactID) CurrSiteMktSvcMgr
	ON CurrSiteMktSvcMgr.SiteContactID = Site.ContactID
LEFT JOIN dbo.MarketSvcMgrAssignment MarketSvcMgrAssignment (NOLOCK)
	ON MarketSvcMgrAssignment.SiteContactID = CurrSiteMktSvcMgr.SiteContactID
	AND MarketSvcMgrAssignment.EffectiveDate = CurrSiteMktSvcMgr.EffectiveDate
LEFT JOIN	dbo.Contact SiteMktSvcMgrContact (NOLOCK)
	ON SiteMktSvcMgrContact.ContactID = MarketSvcMgrAssignment.MarketSvcMgrContactID

LEFT JOIN	dbo.SrSvcMgrAssignment SrSvcMgrAssignment (NOLOCK)
	ON SrSvcMgrAssignment.SvcMgrContactID = SiteSvcMgrAssignment.SvcMgrContactID
LEFT JOIN	dbo.Contact SiteSrSvcMgrContact (NOLOCK)
	ON SiteSrSvcMgrContact.ContactID = SrSvcMgrAssignment.SrSvcMgrContactID
