





CREATE VIEW [dbo].[cfv_DriverCompany]
AS
SELECT DISTINCT 
                         Contact.ContactID AS DriverContactID,
						  Contact.ContactName AS DriverName, Contact.StatusTypeID AS DriverStatus, ra.ParentContactID AS TruckingCompanyContactID, 
                         ISNULL(cc.ContactName, '') AS TruckingCompanyName
FROM            CentralData.dbo.Contact AS Contact WITH (NOLOCK) LEFT OUTER JOIN
                         CentralData.dbo.cftRelationshipAssignment AS ra WITH (NOLOCK) ON Contact.ContactID = ra.ChildContactID AND ra.EndDate IS NULL LEFT OUTER JOIN
                         CentralData.dbo.Contact AS cc WITH (NOLOCK) ON ra.ParentContactID = cc.ContactID
WHERE        (Contact.ContactID IN
                             (SELECT DISTINCT ContactID
                               FROM            CentralData.dbo.ContactRoleType AS CRT
                               WHERE        (RoleTypeID IN (2, 11, 12)))) AND (Contact.ContactTypeID = 3)



