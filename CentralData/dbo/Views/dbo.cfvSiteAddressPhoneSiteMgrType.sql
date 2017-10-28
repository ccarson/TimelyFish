

CREATE VIEW [dbo].[cfvSiteAddressPhoneSiteMgrType]
 (
		Addr1, 
		Addr2, 
		City, 
		State, 
		Zip,
		phone,
		ContactId, 
		ContactName, 
		Type,
		SiteManagerName
		) as
/* Used in programs:  
   Referenced in:  
*/
    SELECT     a.Address1 AS Addr1, a.Address2 AS Addr2, a.City, a.State, a.Zip, p.PhoneNbr AS phone, c.ContactID, c.ContactName, 
                      ct.ContactTypeDescription AS Type, srvm.SiteManager
FROM         dbo.Contact AS c  (nolock) LEFT OUTER JOIN
                      dbo.ContactAddress AS ca  (nolock) ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1 LEFT OUTER JOIN
                      dbo.Address AS a  (nolock) ON ca.AddressID = a.AddressID LEFT OUTER JOIN
                      dbo.ContactPhone AS cp  (nolock) ON cp.ContactID = c.ContactID AND cp.PhoneTypeID = 1 LEFT OUTER JOIN
                      dbo.Phone AS p  (nolock) ON cp.PhoneID = p.PhoneID INNER JOIN
                      dbo.ContactType AS ct  (nolock) ON ct.ContactTypeID = c.ContactTypeID LEFT OUTER JOIN
                      dbo.cfv_SITE_MANAGEMENT_INFO AS srvm  (nolock) ON srvm.ContactID = c.ContactID
WHERE     (c.ContactTypeID IN (1, 4)) AND (c.StatusTypeID = 1)


