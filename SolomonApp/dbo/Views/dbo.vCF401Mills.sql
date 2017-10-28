

CREATE  VIEW [dbo].[vCF401Mills]
	AS


	SELECT  a.addressid, c.ContactID, c.ContactName, Address1 = IsNull(a.Address1,''), Address2 = IsNull(a.Address2,''),
		City = IsNull(a.City,''), State = IsNull(a.State, ''), Zip = IsNull(a.Zip,'')
		FROM
		cftContact c (nolock)	-- 201303 sripley added nolock hint
		JOIN cftContactRoleType rt (nolock) ON c.ContactID = rt.ContactID	-- 201303 sripley added nolock hint
		LEFT JOIN cftContactAddress ca (nolock) ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1	-- 201303 sripley added nolock hint
		LEFT JOIN cftAddress a (nolock) on ca.AddressID = a.AddressID 	-- 201303 sripley added nolock hint
		WHERE rt.RoleTypeID = '010'



