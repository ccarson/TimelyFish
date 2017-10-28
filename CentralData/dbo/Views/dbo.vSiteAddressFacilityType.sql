CREATE   View vSiteAddressFacilityType (Addr1, Addr2, AddrID, City, ContactId, ContactName, County, EMailAddress, MgrContactId, MillId, RRTons, SiteId, State, Zip, 
		FacilityType, MedVendor) as
/* Used in programs:  
   Referenced in:  
*/
    Select a.Address1, a.Address2, a.AddressID, a.City, c.ContactId, c.ContactName, 
	a.County, c.EMailAddress, s.SiteMgrContactID, IsNull(f.ContactId,''), s.RoadRestrictionTons, s.SiteId, 
	a.State, a.Zip, ft.FacilityTypeDescription, mc.ContactName
	from Site s 
		JOIN Contact c on c.ContactId = s.ContactId
		LEFT JOIN Contact f on f.ContactId = s.FeedMillContactID
		JOIN ContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		JOIN Address a on ca.AddressID = a.AddressID 
		JOIN FacilityType ft on s.FacilityTypeID=ft.FacilityTypeID
		LEFT JOIN SiteMedVendor sm on s.ContactID=sm.SiteContactID and sm.VendorContactID <>2069
		LEFT JOIN Contact mc on sm.VendorContactID=mc.ContactID
