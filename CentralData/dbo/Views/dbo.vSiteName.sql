CREATE VIEW dbo.vSiteName
AS
SELECT     dbo.Site.SiteID, dbo.Contact.ContactID, dbo.Contact.ContactName AS DescriptiveName
FROM         dbo.Site INNER JOIN
                      dbo.Contact ON dbo.Site.ContactID = dbo.Contact.ContactID
WHERE     dbo.Contact.StatusTypeID = 1
UNION
SELECT     'XXXX', Null,''
UNION 
SELECT 	'97',97, 'Offload'
UNION 
Select '3095',3095,'Offload - Bloomfield'

