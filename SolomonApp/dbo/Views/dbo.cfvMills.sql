

CREATE   VIEW cfvMills (Address1, Address2, AddressID, City, ContactName, MillId, State, Zip, Tstamp)
	AS
/* Used in programs:  CF300, CF303
   Referenced in:  CF394, CF399
*/
	-- This view is used to display a list of contacts 
	-- that have the contact role of 'Feed Source' (RoleTypeID = 10)
	SELECT Coalesce(a.Address1, ''), Coalesce(a.Address2, ''), Coalesce(a.AddressID, ''), 
		Coalesce(a.City, ''), c.ContactName, 
		c.ContactID, Coalesce(a.State, ''), Coalesce(a.Zip, ''), c.tstamp
		FROM
		cftContact c
		JOIN cftContactRoleType rt ON c.ContactID = rt.ContactID
		Left JOIN cftContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		Left JOIN cftAddress a on ca.AddressID = a.AddressID 
		WHERE rt.RoleTypeID = '010' and c.StatusTypeId = '1'



