
/****** Object:  View dbo.cfvSiteDetail    Script Date: 12/2/2005 7:35:59 AM ******/

/****** Sue Matter:  Used on Active Site Report    Script Date: 11/23/2004 11:54:21 AM ******/

CREATE VIEW cfvSiteDetail (SiteContactID, SiteID, SiteName, PigGroupID, FacilityType, State, SiteOwnershipDescription, County)
	AS
Select pg.SiteContactID, st.SiteID, cn.ContactName AS SiteName, pg.PigGroupID, fc.Description As FacilityType, ad.State, ot.Description, ad.County
From cftPigGroup pg WITH (NOLOCK)
LEFT JOIN cftSite st WITH (NOLOCK) ON pg.SiteContactID=st.ContactID
LEFT JOIN cftFacilityType fc WITH (NOLOCK) ON st.FacilityTypeID=fc.FacilityTypeID
LEFT JOIN cftContact cn WITH (NOLOCK) ON pg.SiteContactID=cn.ContactID
LEFT JOIN cftContactAddress ca WITH (NOLOCK) ON cn.ContactID=ca.ContactID AND ca.AddressTypeID='01'
LEFT JOIN cftAddress ad WITH (NOLOCK) ON ca.AddressID=ad.AddressID
LEFT JOIN cftOwnershipType ot WITH (NOLOCK) ON st.OwnerShipTypeID=ot.OwnerShipTypeID





 
