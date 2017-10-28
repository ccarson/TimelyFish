

/****** Object:  View dbo.cfvCurrentMktSvcMgr    Script Date: 12/1/2005 8:19:43 PM ******/
/*  2012-07-11 smr added nolock to the tables */
CREATE  VIEW [dbo].[cfvCurrentMktSvcMgr]
	AS
	-- This view is used to display the current service manager 
select mk.sitecontactid,
MktMgrContactID,
mk.Effectivedate, 
ct.ContactName
	FROM cftMktMgrAssign mk (nolock)
	JOIN cftContact ct (nolock) ON mk.MktMgrContactID=ct.ContactID
	WHERE mk.EffectiveDate = (Select max(effectivedate) 
			FROM cftMktMgrAssign (nolock)
			WHERE mk.SiteContactID = SiteContactID 
			AND effectivedate <=getDate())



