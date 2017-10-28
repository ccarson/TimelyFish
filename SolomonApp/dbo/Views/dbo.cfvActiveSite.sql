-- ==========================================================================================================
-- Date			Author				Change Description
-- ----------   ------------------	-------------------------------------------------------------------------
-- 3/26/2014	Nick Honetschlager	Created new view, like cfvSite, to only show active sites.
--									Used in pXF120cfvSite_ContactId
--
-- ==========================================================================================================
CREATE View [dbo].[cfvActiveSite] (Addr1, Addr2, AddrID, City, ContactId, ContactName, County, EMailAddress, MgrContactId, MillId, RRTons, SiteId, State, Zip, Tstamp) as

    Select a.Address1, a.Address2, a.AddressID, a.City, c.ContactId, c.ContactName, 
	a.County, c.EMailAddress, s.SiteMgrContactID, IsNull(f.ContactId,''), s.RoadRestrictionTons, s.SiteId, 
	a.State, a.Zip, c.tstamp
	from cftSite s 
		JOIN cftContact c on c.ContactId = s.ContactId 
		LEFT JOIN cftContact f on f.ContactId = s.FeedMillContactID
		JOIN cftContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		JOIN cftAddress a on ca.AddressID = a.AddressID 
	WHERE c.StatusTypeID = 1

 



