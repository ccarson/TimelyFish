



create VIEW [dbo].[cfv_DriverCompany]
AS
SELECT DISTINCT 
                         Contact.ContactID AS DriverContactID,
						  Contact.ContactName AS DriverName, 
						  Contact.StatusTypeID AS DriverStatus, 
						  CASE
							WHEN Contact.ContactTypeID = 3 THEN
								ra.ParentContactID  
							ELSE
								Contact.ContactID
						   END AS TruckingCompanyContactID, 
						   CASE
							WHEN Contact.ContactTypeID = 3 THEN
								ISNULL(cc.ContactName, '') 
							ELSE
								Contact.ContactName 
						   END AS TruckingCompanyName
FROM            dbo.Contact AS Contact WITH (NOLOCK) LEFT OUTER JOIN
                         dbo.cftRelationshipAssignment AS ra WITH (NOLOCK) ON Contact.ContactID = ra.ChildContactID AND ra.EndDate IS NULL LEFT OUTER JOIN
                         dbo.Contact AS cc WITH (NOLOCK) ON ra.ParentContactID = cc.ContactID
WHERE        (Contact.ContactID IN
                             (SELECT DISTINCT ContactID
                               FROM            dbo.ContactRoleType AS CRT
                               WHERE        (RoleTypeID IN (2, 11, 12)))) --AND (Contact.ContactTypeID = 3)




