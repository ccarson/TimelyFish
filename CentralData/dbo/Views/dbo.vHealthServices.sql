
CREATE VIEW dbo.vHealthServices
AS
SELECT     dbo.HealthServices.VetVisit, dbo.HealthServices.Tattoo, dbo.HealthServices.Age, dbo.FacilityType.FacilityTypeDescription, 
                      dbo.FacilityType.FacilityTypeID, dbo.HealthServices.VetContactID, dbo.Contact.ContactName
FROM         dbo.Site INNER JOIN
                      dbo.HealthServices ON dbo.Site.ContactID = dbo.HealthServices.ContactID LEFT OUTER JOIN
                      dbo.Contact ON dbo.HealthServices.ContactID = dbo.Contact.ContactID LEFT OUTER JOIN
                      dbo.Address INNER JOIN
                      dbo.ContactAddress ON dbo.Address.AddressID = dbo.ContactAddress.AddressID ON 
                      dbo.HealthServices.ContactID = dbo.ContactAddress.ContactID LEFT OUTER JOIN
                      dbo.FacilityType ON dbo.Site.FacilityTypeID = dbo.FacilityType.FacilityTypeID
WHERE     (dbo.Contact.StatusTypeID =1) AND (dbo.Address.State in ('MN','IA','SD','IL'))
 AND (dbo.ContactAddress.AddressTypeID = '1')
