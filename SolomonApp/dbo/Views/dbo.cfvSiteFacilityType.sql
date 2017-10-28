Create  View cfvSiteFacilityType (Addr1, Addr2, AddrID, City, ContactId, ContactName, County, EMailAddress, MgrContactId, MillId, RRTons, SiteId, State, Zip, 
		FacilityType, Tstamp) as
/* Used in programs:  CF300, CF303, CF320, CF330, CF340
   Referenced in:  CF301
*/
    Select a.Address1, a.Address2, a.AddressID, a.City, c.ContactId, c.ContactName, 
	a.County, c.EMailAddress, s.SiteMgrContactID, IsNull(f.ContactId,''), s.RoadRestrictionTons, s.SiteId, 
	a.State, a.Zip, ft.Description, c.tstamp
	from cftSite s 
		JOIN cftContact c on c.ContactId = s.ContactId
		LEFT JOIN cftContact f on f.ContactId = s.FeedMillContactID
		JOIN cftContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		JOIN cftAddress a on ca.AddressID = a.AddressID 
		JOIN cftFacilityType ft on s.FacilityTypeID=ft.FacilityTypeID



 
