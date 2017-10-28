CREATE VIEW dbo.vPacker
AS
SELECT     dbo.Packer.ContactID, dbo.Contact.ContactName, dbo.Packer.TrackTotals
FROM         dbo.Packer INNER JOIN
                      dbo.Contact ON dbo.Packer.ContactID = dbo.Contact.ContactID
UNION
SELECT     9999, ' ', 0
UNION 
Select 	97, 'Offload', 0
UNION 
Select 3095,'Offload - Bloomfield',0

