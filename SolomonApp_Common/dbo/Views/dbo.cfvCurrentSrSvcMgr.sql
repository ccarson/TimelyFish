

CREATE VIEW [dbo].[cfvCurrentSrSvcMgr]
AS
SELECT 
s.SiteID, s.ContactID, c.ContactName, SSM.SrSvcContactID, SSM.SrSvcName, SSM.EffectiveDate SrSvcMgrEffectiveDate, SM.SvcContactID, SM.SvcMgrName, SM.EffectiveDate SvcMrgEffectiveDate
FROM dbo.cftSite s
LEFT JOIN dbo.cftContact c ON s.ContactID = c.ContactID
left join
	(select
	sm1.SiteContactID,
	c2.ContactName SiteName,
	sm2.ProdSvcMgrContactID,
	sm2.EffectiveDate,
	c.ContactID SrSvcContactID,
	c.ContactName SrSvcName
	from
		(select SiteContactID,
		Max(EffectiveDate) EffectiveDate
		from dbo.cftProdSvcMgr
		group by
		SiteContactID) sm1
	left join dbo.cftProdSvcMgr sm2 on sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
	left join dbo.cftContact c on c.ContactID=sm2.ProdSvcMgrContactID
	left join dbo.cftContact c2 on c2.ContactID=sm1.SiteContactID) SSM
on SSM.SiteContactID=s.ContactID

left join
	(select
	sm1.SiteContactID,
	c2.ContactName SiteName,
	sm2.SvcMgrContactID,
	sm2.EffectiveDate,
	c.ContactID SvcContactID,
	c.ContactName SvcMgrName
	from
		(select SiteContactID,
		Max(EffectiveDate) EffectiveDate
		from dbo.cftSiteSvcMgrAsn
		group by
		SiteContactID) sm1
	left join dbo.cftSiteSvcMgrAsn sm2 on sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
	left join dbo.cftContact c on c.ContactID=sm2.SvcMgrContactID
	left join dbo.cftContact c2 on c2.ContactID=sm1.SiteContactID) SM
on SM.SiteContactID=s.ContactID

where 
c.StatusTypeID='1'
--and FacilityTypeID<>1
and Siteid not in ('9999','1660','8000','8010','0001','9998','9997')

