CREATE VIEW vCF651Mills
	AS


	SELECT  a.addressid, c.ContactID, c.ContactName, Address1 = IsNull(a.Address1,''), Address2 = IsNull(a.Address2,''),
		City = IsNull(a.City,''), State = IsNull(a.State, ''), Zip = IsNull(a.Zip,'')
		FROM
		cftContact c
		JOIN cftContactRoleType rt ON c.ContactID = rt.ContactID
		LEFT JOIN cftContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		LEFT JOIN cftAddress a on ca.AddressID = a.AddressID 
		WHERE rt.RoleTypeID = '010'

